//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#include "VideoPipeline.h"

#include <iostream>

#include "Utils/GLUtils.h"

namespace av {

IVideoPipeline* IVideoPipeline::Create(GLContext& glContext) { return new VideoPipeline(glContext); }

VideoPipeline::VideoPipeline(GLContext& glContext)
    : m_sharedGLContext(glContext), m_thread(std::make_shared<std::thread>(&VideoPipeline::ThreadLoop, this)) {}

VideoPipeline::~VideoPipeline() { Stop(); }

void VideoPipeline::SetListener(Listener* listener) {
    std::lock_guard<std::recursive_mutex> lock(m_listenerMutex);
    m_listener = listener;
}

std::shared_ptr<IVideoFilter> VideoPipeline::AddVideoFilter(VideoFilterType type) {
    std::lock_guard<std::mutex> lock(m_videoFilterMutex);
    // 如果已经存在相同类型的滤镜，则不再添加
    for (auto& filter : m_videoFilters) {
        if (filter->GetType() == type) return filter;
    }

    auto filter = std::shared_ptr<VideoFilter>(VideoFilter::Create(type));
    if (filter) m_videoFilters.push_back(filter);
    return filter;
}

void VideoPipeline::RemoveVideoFilter(VideoFilterType type) {
    std::lock_guard<std::mutex> lock(m_videoFilterMutex);
    for (auto it = m_videoFilters.begin(); it != m_videoFilters.end(); ++it) {
        if ((*it)->GetType() == type) {
            m_removedVideoFilters.push_back(*it);
            it = m_videoFilters.erase(it);
            break;
        }
    }
}

void VideoPipeline::NotifyVideoFrame(std::shared_ptr<IVideoFrame> videoFrame) {
    std::lock_guard<std::mutex> lock(m_queueMutex);
    m_frameQueue.push_back(videoFrame);
    m_queueCondVar.notify_one();
}

void VideoPipeline::NotifyVideoFinished() {
    std::lock_guard<std::recursive_mutex> lock(m_listenerMutex);
    if (m_listener) m_listener->OnVideoPipelineNotifyFinished();
}

void VideoPipeline::Stop() {
    {
        std::lock_guard<std::mutex> lock(m_queueMutex);
        m_abort = true;
        m_queueCondVar.notify_all();
    }
    if (m_thread->joinable()) m_thread->join();
}

void VideoPipeline::PrepareTempTexture(int width, int height) {
    if (m_tempTexture.id == 0) {
        glGenTextures(1, &m_tempTexture.id);
        glBindTexture(GL_TEXTURE_2D, m_tempTexture.id);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, nullptr);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        m_tempTexture.width = width;
        m_tempTexture.height = height;
    } else if (m_tempTexture.width != width || m_tempTexture.height != height) {
        glBindTexture(GL_TEXTURE_2D, m_tempTexture.id);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, nullptr);
        m_tempTexture.width = width;
        m_tempTexture.height = height;
    }
}

void VideoPipeline::PrepareVideoFrame(std::shared_ptr<IVideoFrame> frame) {
    glGenTextures(1, &frame->textureId);
    glBindTexture(GL_TEXTURE_2D, frame->textureId);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, frame->width, frame->height, 0, GL_RGBA, GL_UNSIGNED_BYTE,
                 frame->data.get());
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    // 垂直翻转画面
    if (!m_flipVerticalFilter) {
        m_flipVerticalFilter = std::shared_ptr<VideoFilter>(VideoFilter::Create(VideoFilterType::kFlipVertical));
    }
    if (m_flipVerticalFilter) {
        m_flipVerticalFilter->Render(frame, m_tempTexture.id);
    }

    std::swap(frame->textureId, m_tempTexture.id);
}

void VideoPipeline::RenderVideoFilter(std::shared_ptr<IVideoFrame> frame) {
    PrepareTempTexture(frame->width, frame->height);

    std::lock_guard<std::mutex> lock(m_videoFilterMutex);
    m_removedVideoFilters.clear();
    if (m_videoFilters.empty()) return;

    auto inputTexture = frame->textureId;
    auto outputTexture = m_tempTexture.id;

    auto filterRenderCount = 0;
    for (auto& filter : m_videoFilters) {
        if (filter->Render(frame, outputTexture)) {
            ++filterRenderCount;
            std::swap(inputTexture, outputTexture);
        }
    }

    if (filterRenderCount % 2 == 1) std::swap(frame->textureId, m_tempTexture.id);
}

void VideoPipeline::ThreadLoop() {
    m_sharedGLContext.Initialize();
    m_sharedGLContext.MakeCurrent();

    unsigned int fbo{0};
    glGenFramebuffers(1, &fbo);
    glBindFramebuffer(GL_FRAMEBUFFER, fbo);

    for (;;) {
        std::shared_ptr<IVideoFrame> frame;
        {
            std::unique_lock<std::mutex> lock(m_queueMutex);
            m_queueCondVar.wait(lock, [this] { return m_abort || !m_frameQueue.empty(); });
            if (m_abort) break;
            frame = m_frameQueue.front();
            m_frameQueue.pop_front();
        }

        if (frame) {
            PrepareVideoFrame(frame);
            RenderVideoFilter(frame);
            glFinish();

            std::lock_guard<std::recursive_mutex> lock(m_listenerMutex);
            if (m_listener) m_listener->OnVideoPipelineNotifyVideoFrame(frame);
        }
    }

    {
        std::lock_guard<std::mutex> lock(m_queueMutex);
        m_frameQueue.clear();
    }

    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glDeleteFramebuffers(1, &fbo);
    m_sharedGLContext.DoneCurrent();
    m_sharedGLContext.Destroy();
}

}  // namespace av