//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#include <iostream>

#include "IGLContext.h"

namespace av {

GLContext::GLContext(QOpenGLContext *sharedGLContext) : m_sharedGLContext(sharedGLContext) {}

GLContext::~GLContext() {
    DoneCurrent();
    Destroy();
}

bool GLContext::Initialize() {
    if (!m_sharedGLContext) {
        std::cerr << "Shared GL context is null!" << std::endl;
        return false;
    }

    m_context = new QOpenGLContext();
    m_context->setShareContext(m_sharedGLContext);
    if (!m_context->create()) {
        std::cerr << "Failed to create GL context!" << std::endl;
        return false;
    }

    m_surface = new QOffscreenSurface();
    m_surface->create();
    m_context->makeCurrent(m_surface);

    return true;
}

void GLContext::Destroy() {
    if (m_surface) {
        delete m_surface;
        m_surface = nullptr;
    }

    if (m_context) {
        delete m_context;
        m_context = nullptr;
    }
}

void GLContext::MakeCurrent() {
    if (m_context && m_surface) m_context->makeCurrent(m_surface);
}

void GLContext::DoneCurrent() {
    if (m_context) m_context->doneCurrent();
}

}  // namespace av