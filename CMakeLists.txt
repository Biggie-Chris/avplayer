cmake_minimum_required(VERSION 3.21)
project(av_player VERSION 0.0.1)

# ----- 编译选项 -----
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# ----- 路径与宏 -----
set(PROJECT_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(RESOURCE_DIR "${PROJECT_ROOT_DIR}/resource")
set(CACHE_DIR    "${PROJECT_ROOT_DIR}/cache")
add_definitions(-DRESOURCE_DIR="${RESOURCE_DIR}")
add_definitions(-DCACHE_DIR="${CACHE_DIR}")

# ----- 第三方（Conan导入的包）-----
find_package(ffmpeg REQUIRED)
find_package(stb    REQUIRED)
find_package(glm    REQUIRED)

# （Conan通常会自己设置include目录；以下两行不是必须，可省略）
# include_directories(${ffmpeg_INCLUDE_DIRS})
# include_directories(${stb_INCLUDE_DIRS})

# ----- Qt6 -----
list(PREPEND CMAKE_PREFIX_PATH "F:/Qt/6.7.3/6.7.3/msvc2022_64/lib/cmake")
set(Qt6_DIR "F:/Qt/6.7.3/msvc2022_64/lib/cmake/Qt6" CACHE PATH "" FORCE)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets OpenGL OpenGLWidgets Multimedia Quick)

# ===== 静态库 av_player =====
file(GLOB_RECURSE LIBRARY_SOURCE_FILES
    ${PROJECT_ROOT_DIR}/LearnAV/*.cpp
    ${PROJECT_ROOT_DIR}/LearnAV/*.h
)

add_library(${PROJECT_NAME} STATIC ${LIBRARY_SOURCE_FILES})

# 如果库里也用到 Qt API，链接上 Qt（没有用到可以删掉这三项）
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Core Qt6::Gui Qt6::Widgets
        ffmpeg::ffmpeg stb::stb glm::glm
)

# InspireFace（Windows 下用 .lib；Linux 用 .so；macOS 用 .dylib）
if (WIN32)
  find_library(InspireFace_LIB
    NAMES InspireFace
    PATHS "${PROJECT_ROOT_DIR}/3rdparty/InspireFace/lib"
    NO_DEFAULT_PATH
  )
elseif(APPLE)
  find_library(InspireFace_LIB
    NAMES InspireFace libInspireFace
    PATHS "${PROJECT_ROOT_DIR}/3rdparty/InspireFace/lib"
    NO_DEFAULT_PATH
  )
else()
  find_library(InspireFace_LIB
    NAMES InspireFace libInspireFace
    PATHS "${PROJECT_ROOT_DIR}/3rdparty/InspireFace/lib"
    NO_DEFAULT_PATH
  )
endif()

if (InspireFace_LIB)
  target_link_libraries(${PROJECT_NAME} PRIVATE ${InspireFace_LIB})
else()
  message(WARNING "InspireFace library not found; building without it.")
endif()

# ===== 可执行程序 QtDemo =====
file(GLOB DEMO_SOURCE_FILES
    ${PROJECT_ROOT_DIR}/qt/*.cpp
    ${PROJECT_ROOT_DIR}/qt/*.h
    ${PROJECT_ROOT_DIR}/qt/UI/*.cpp
    ${PROJECT_ROOT_DIR}/qt/UI/*.h
)

add_executable(QtDemo ${DEMO_SOURCE_FILES})

target_include_directories(QtDemo PRIVATE
    ${PROJECT_ROOT_DIR}/qt
)

target_link_libraries(QtDemo
    PRIVATE
        Qt6::Core Qt6::Gui Qt6::Widgets
        Qt6::OpenGL Qt6::OpenGLWidgets
        Qt6::Multimedia Qt6::Quick
        ${PROJECT_NAME}
)

# 若 InspireFace 是 DLL，运行时需要拷贝到可执行目录（可选）
if (WIN32 AND EXISTS "${PROJECT_ROOT_DIR}/3rdparty/InspireFace/bin/InspireFace.dll")
  add_custom_command(TARGET QtDemo POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
      "${PROJECT_ROOT_DIR}/3rdparty/InspireFace/bin/InspireFace.dll"
      $<TARGET_FILE_DIR:QtDemo>)
endif()

# Qt 安装目录（按你的实际路径改）
set(QT_BIN_DIR "F:/Qt/6.7.3/6.7.3/msvc2022_64/bin")

# 根据配置选择 debug/release
set(QT_DEPLOY_MODE "$<IF:$<CONFIG:Debug>,--debug,--release>")

add_custom_command(TARGET QtDemo POST_BUILD
  COMMAND "${QT_BIN_DIR}/windeployqt.exe" ${QT_DEPLOY_MODE}
          --no-translations            # 可选：不拷贝翻译
          --compiler-runtime           # 可选：拷贝 MSVC 运行库
          "$<TARGET_FILE:QtDemo>"
  COMMENT "Running windeployqt..."
)

if(MSVC)
    target_include_directories(QtDemo SYSTEM PRIVATE
        "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/include"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/ucrt"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/um"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/shared"
    )
endif()