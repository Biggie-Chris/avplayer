//
// Copyright (c) 2024 Yellow. All rights reserved.
//

#include "GLUtils.h"

// 注意：这里需要定义STB_IMAGE_IMPLEMENTATION，否则编译器会报错
#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>

#include <iostream>

#include "IGLContext.h"

namespace av {

static unsigned int CompileShader(unsigned int type, const char* source) {
    unsigned int shader = glCreateShader(type);
    glShaderSource(shader, 1, &source, nullptr);
    glCompileShader(shader);

    int success;
    char infoLog[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, nullptr, infoLog);
        std::cerr << "ERROR::SHADER::COMPILATION_FAILED\n" << infoLog << std::endl;
    }
    return shader;
}

unsigned int GLUtils::CompileAndLinkProgram(const char* vertexShaderSource, const char* fragmentShaderSource) {
    auto vertexShader = CompileShader(GL_VERTEX_SHADER, vertexShaderSource);
    auto fragmentShader = CompileShader(GL_FRAGMENT_SHADER, fragmentShaderSource);
    auto shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    return shaderProgram;
}

bool GLUtils::CheckGLError(const char* tag) {
    bool noErr = true;
    for (;;) {
        GLenum error = glGetError();
        if (error == GL_NO_ERROR) {
            return noErr;
        }
        noErr = false;
        std::cerr << tag << " glGetError (0x" << std::hex << error << std::endl;
    }
}

GLuint GLUtils::GenerateTexture(int width, int height, GLenum internalFormat, GLenum format) {
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    glTexImage2D(GL_TEXTURE_2D, 0, internalFormat, width, height, 0, format, GL_UNSIGNED_BYTE, NULL);
    glBindTexture(GL_TEXTURE_2D, 0);
    return texture;
}

GLuint GLUtils::LoadImageFileToTexture(const std::string& imagePath, int& width, int& height) {
    GLuint texture = 0;
    int nrChannels;
    unsigned char* data = stbi_load(imagePath.c_str(), &width, &height, &nrChannels, STBI_rgb_alpha);
    if (data) {
        glGenTextures(1, &texture);
        glBindTexture(GL_TEXTURE_2D, texture);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
        glGenerateMipmap(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, 0);
        stbi_image_free(data);
    } else {
        std::cerr << "Failed to load texture: " << imagePath << std::endl;
    }
    return texture;
}

}  // namespace av