add_executable(demux demux.cpp)
target_link_libraries(demux PRIVATE
  av_player
  ffmpeg::avformat
  ffmpeg::avcodec
  ffmpeg::avutil
  ffmpeg::swscale
)
target_include_directories(demux SYSTEM PRIVATE
        "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/include"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/ucrt"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/um"
        "C:/Program Files (x86)/Windows Kits/10/Include/10.0.19041.0/shared"
)
get_target_property(_demux_links demux LINK_LIBRARIES)
message(STATUS "demux LINK_LIBRARIES = ${_demux_links}")

get_target_property(_imp_avformat ffmpeg::avformat IMPORTED_IMPLIB)
get_target_property(_loc_avformat ffmpeg::avformat IMPORTED_LOCATION)
message(STATUS "avformat: implib=${_imp_avformat} loc=${_loc_avformat}")
