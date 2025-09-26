//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#include "FileWriter.h"

#include <iostream>

namespace av {

IFileWriter* IFileWriter::Create(GLContext& glContext) { return new FileWriter(glContext); }

FileWriter::FileWriter(GLContext& glContext) {
    m_audioEncoder = std::make_shared<AudioEncoder>();
    m_videoEncoder = std::make_shared<VideoEncoder>(glContext);
    m_muxer = std::make_shared<Muxer>();

    m_audioEncoder->SetListener(this);
    m_videoEncoder->SetListener(this);
}

FileWriter::~FileWriter() {
    StopWriter();
    m_audioEncoder = nullptr;
    m_videoEncoder = nullptr;
    m_muxer = nullptr;
}

bool FileWriter::StartWriter(const std::string& outputFilePath, FileWriterParameters& parameters, int flags) {
    auto succ1 = m_audioEncoder->Configure(parameters, flags);
    auto succ2 = m_videoEncoder->Configure(parameters, flags);
    auto succ3 = m_muxer->Configure(outputFilePath, parameters, flags);
    std::cout << "FileWriter::StartWriter: " << succ1 << " " << succ2 << " " << succ3 << std::endl;
    return succ1 && succ2 && succ3;
}

void FileWriter::StopWriter() {
    NotifyAudioFinished();
    NotifyVideoFinished();
}

void FileWriter::NotifyAudioSamples(std::shared_ptr<IAudioSamples> audioSamples) {
    if (m_audioEncoder) m_audioEncoder->NotifyAudioSamples(audioSamples);
}

void FileWriter::NotifyVideoFrame(std::shared_ptr<IVideoFrame> videoFrame) {
    if (m_videoEncoder) m_videoEncoder->NotifyVideoFrame(videoFrame);
}

void FileWriter::NotifyAudioFinished() {
    auto audioSamples = std::make_shared<IAudioSamples>();
    audioSamples->flags |= AVFrameFlag::kEOS;
    NotifyAudioSamples(audioSamples);
}

void FileWriter::NotifyVideoFinished() {
    auto videoFrame = std::make_shared<IVideoFrame>();
    videoFrame->flags |= AVFrameFlag::kEOS;
    NotifyVideoFrame(videoFrame);
}

// 继承自 AudioEncoder::Listener
void FileWriter::OnAudioEncoderNotifyPacket(std::shared_ptr<IAVPacket> packet) {
    if (m_muxer) m_muxer->NotifyAudioPacket(packet);
}

void FileWriter::OnAudioEncoderNotifyFinished() {
    if (m_muxer) m_muxer->NotifyAudioFinished();
}

// 继承自 VideoEncoder::Listener
void FileWriter::OnVideoEncoderNotifyPacket(std::shared_ptr<IAVPacket> packet) {
    if (m_muxer) m_muxer->NotifyVideoPacket(packet);
}

void FileWriter::OnVideoEncoderNotifyFinished() {
    if (m_muxer) m_muxer->NotifyVideoFinished();
}

}  // namespace av