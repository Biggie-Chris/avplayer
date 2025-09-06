message(STATUS "Conan: Using CMakeDeps conandeps_legacy.cmake aggregator via include()")
message(STATUS "Conan: It is recommended to use explicit find_package() per dependency instead")

find_package(ffmpeg)
find_package(stb)
find_package(glm)

set(CONANDEPS_LEGACY  ffmpeg::ffmpeg  stb::stb  glm::glm )