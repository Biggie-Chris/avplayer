//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#ifndef LEARNAV_AUDIOSPEAKER_H
#define LEARNAV_AUDIOSPEAKER_H

#include <QAudioDevice>
#include <QAudioFormat>
#include <QAudioSink>
#include <QIODevice>
#include <QMediaDevices>
#include <list>
#include <mutex>

#include "Interface/IAudioSpeaker.h"

namespace av {

class AudioSpeaker : public IAudioSpeaker, public QIODevice {
public:
    AudioSpeaker(unsigned int channels, unsigned int sampleRate);
    ~AudioSpeaker() override;

    void PlayAudioSamples(std::shared_ptr<IAudioSamples> audioSamples) override;
    void Stop() override;

private:
    qint64 readData(char *data, qint64 maxlen) override;
    qint64 writeData(const char *data, qint64 len) override;

private:
    QAudioSink *m_audioSink{nullptr};
    QMediaDevices *m_outputDevices{nullptr};
    QAudioDevice outputDevice;
    QAudioSink *m_audioSinkOutput{nullptr};
    IAudioSamples m_audioSamples;

    std::list<std::shared_ptr<IAudioSamples>> m_audioSamplesList;
    std::mutex m_audioSamplesListMutex;
};

}  // namespace av

#endif  // LEARNAV_AUDIOSPEAKER_H
