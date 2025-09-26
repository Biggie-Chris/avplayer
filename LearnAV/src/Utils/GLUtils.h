//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#ifndef LEARNAV_GLUTILS_H
#define LEARNAV_GLUTILS_H

#include "IGLContext.h"

namespace av {

struct GLUtils {
    static unsigned int CompileAndLinkProgram(const char* vertexShaderSource, const char* fragmentShaderSource);
    static bool CheckGLError(const char* tag = "");
    static GLuint GenerateTexture(int width, int height, GLenum internalFormat, GLenum format);
    static GLuint LoadImageFileToTexture(const std::string& imagePath, int& width, int& height);
};

}  // namespace av

#endif  // LEARNAV_GLUTILS_H
