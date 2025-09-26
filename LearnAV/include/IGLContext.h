//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#ifndef LEARNAV_IGLCONTEXT_H
#define LEARNAV_IGLCONTEXT_H

// 定义不同平台的OpenGL上下文，这里只定义了QT的OpenGL上下文
#include <QOffscreenSurface>
#include <QOpenGLContext>

namespace av {

class GLContext {
public:
    explicit GLContext(QOpenGLContext *context);
    virtual ~GLContext();

    bool Initialize();   // 初始化OpenGL上下文
    void Destroy();      // 销毁OpenGL上下文
    void MakeCurrent();  // 设置当前OpenGL上下文
    void DoneCurrent();  // 释放当前OpenGL上下文

private:
    QOpenGLContext *m_sharedGLContext{nullptr};
    QOpenGLContext *m_context{nullptr};
    QOffscreenSurface *m_surface{nullptr};
};

}  // namespace av

#endif  // LEARNAV_IGLCONTEXT_H
