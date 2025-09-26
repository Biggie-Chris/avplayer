cmake_minimum_required(VERSION 3.21)
project(my_player VERSION 0.0.1)

# ----- 编译选项 -----
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)


# ----- 路径与宏 -----
set(PROJECT_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(RESOURCE_DIR "${PROJECT_ROOT_DIR}/resource")
set(CACHE_DIR    "${PROJECT_ROOT_DIR}/cache")
add_definitions(-DRESOURCE_DIR="${RESOURCE_DIR}")
add_definitions(-DCACHE_DIR="${CACHE_DIR}")

# ----- 使用 vcpkg 导入第三方包 -----
find_package(ffmpeg REQUIRED)
find_package(OpenCV REQUIRED)
find_package(stb REQUIRED)
find_package(glm REQUIRED)

# ----- Qt6 -----
list(PREPEND CMAKE_PREFIX_PATH "F:/Qt/6.7.3/6.7.3/msvc2022_64/lib/cmake")
find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets OpenGL OpenGLWidgets Multimedia Quick)

# ===== 静态库 my_player =====
file(GLOB_RECURSE LIBRARY_SOURCE_FILES
    ${PROJECT_ROOT_DIR}/LearnAV/*.cpp
    ${PROJECT_ROOT_DIR}/LearnAV/*.h
)

add_library(${PROJECT_NAME} STATIC ${LIBRARY_SOURCE_FILES})

# 头文件路径
target_include_directories(${PROJECT_NAME} PRIVATE
    ${PROJECT_ROOT_DIR}/LearnAV
    ${PROJECT_ROOT_DIR}/LearnAV/src
    ${PROJECT_ROOT_DIR}/LearnAV/src/Interface
    ${stb_INCLUDE_DIRS}
    ${glm_INCLUDE_DIRS}
)

# 链接库
target_link_libraries(${PROJECT_NAME} PRIVATE
    avcodec
    avformat
    avutil
    swresample
    swscale
    ${OpenCV_LIBS}
)

# ===== QtDemo 可执行程序 =====
file(GLOB_RECURSE DEMO_SOURCE_FILES
    ${PROJECT_ROOT_DIR}/qt/*.cpp
    ${PROJECT_ROOT_DIR}/qt/*.h
)

add_executable(QtDemo ${DEMO_SOURCE_FILES})

# 为 QtDemo 添加头文件路径
target_include_directories(QtDemo PRIVATE ${PROJECT_ROOT_DIR}/qt ${PROJECT_ROOT_DIR}/LearnAV/qt)
# 为 QtDemo 添加链接库
target_link_libraries(QtDemo Qt6::Core Qt6::Gui Qt6::Widgets Qt6::OpenGL Qt6::OpenGLWidgets Qt6::Multimedia Qt6::Quick ${PROJECT_NAME})

# ===== 部署 Qt DLL =====
set(QT_BIN_DIR "F:/Qt/6.7.3/6.7.3/msvc2022_64/bin")
set(QT_DEPLOY_MODE "$<IF:$<CONFIG:Debug>,--debug,--release>")

add_custom_command(TARGET QtDemo POST_BUILD
  COMMAND "${QT_BIN_DIR}/windeployqt.exe" ${QT_DEPLOY_MODE}
          --no-translations
          --compiler-runtime
          "$<TARGET_FILE:QtDemo>"
  COMMENT "Running windeployqt..."
)

# ===== MSVC 兼容设置 =====
if(MSVC)
    target_include_directories(QtDemo SYSTEM PRIVATE
        "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/include"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/ucrt"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/um"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/shared"
    )
endif()