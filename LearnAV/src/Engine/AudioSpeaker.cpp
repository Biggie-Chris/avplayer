//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#include "AudioSpeaker.h"

#include <stdint.h>
#include <stdio.h>

#include <iostream>

namespace av {

IAudioSpeaker *IAudioSpeaker::Create(unsigned int channels, unsigned int sampleRate) {
    return new AudioSpeaker(channels, sampleRate);
}

AudioSpeaker::AudioSpeaker(unsigned int channels, unsigned int sampleRate) {
    m_outputDevices = new QMediaDevices(nullptr);
    outputDevice = m_outputDevices->defaultAudioOutput();
    QAudioFormat format = outputDevice.preferredFormat();

    // 确保格式与输入音频一致
    format.setChannelCount(channels);
    format.setSampleRate(sampleRate);
    format.setSampleFormat(QAudioFormat::Int16);  // 使用 16 位的音频数据格式

    std::cout << "sampleRate: " << format.sampleRate() << ", channelCount: " << format.channelCount()
              << ", sampleFormat: " << format.sampleFormat() << std::endl;

    // 初始化 QAudioSink
    m_audioSinkOutput = new QAudioSink(outputDevice, format);

    // 增大缓冲区大小，避免频繁的数据耗尽问题
    m_audioSinkOutput->setBufferSize(16384);  // 调整缓冲区大小为 16 KB

    // 启动音频设备之前确保读取音频流
    open(QIODevice::ReadOnly);
    m_audioSinkOutput->start(this);  // 启动音频输出
}

AudioSpeaker::~AudioSpeaker() {
    close();
    m_audioSinkOutput->stop();  // 停止音频播放
}

void AudioSpeaker::PlayAudioSamples(std::shared_ptr<IAudioSamples> audioSamples) {
    if (!audioSamples) return;

    std::lock_guard<std::mutex> lock(m_audioSamplesListMutex);
    m_audioSamplesList.push_back(audioSamples);
}

void AudioSpeaker::Stop() {
    std::lock_guard<std::mutex> lock(m_audioSamplesListMutex);
    m_audioSamplesList.clear();
}

qint64 AudioSpeaker::readData(char *data, qint64 maxlen) {
    if (m_audioSamples.pcmData.empty() || m_audioSamples.offset >= m_audioSamples.pcmData.size()) {
        std::lock_guard<std::mutex> lock(m_audioSamplesListMutex);
        if (m_audioSamplesList.empty()) return 0;
        m_audioSamples = *m_audioSamplesList.front();
        m_audioSamplesList.pop_front();
    }

    // 计算实际可以读取的字节数，避免超出 buffer
    size_t bytesToRead = std::min(static_cast<size_t>(maxlen),
                                  (m_audioSamples.pcmData.size() - m_audioSamples.offset) * sizeof(int16_t));
    std::memcpy(data, m_audioSamples.pcmData.data() + m_audioSamples.offset, bytesToRead);

    // 更新音频样本的偏移量，如果音频样本的数据全部读完，则移出队列
    m_audioSamples.offset += bytesToRead / sizeof(int16_t);

    return bytesToRead;  // 返回读取的字节数
}

qint64 AudioSpeaker::writeData(const char *data, qint64 len) { return 0; }

}  // namespace av
