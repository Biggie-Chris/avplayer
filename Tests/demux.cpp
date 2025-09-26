#include <iostream>
#include <string>
#include "demux.h"
/*
* DeMUXER 类封转了 FFmpeg 的解复用功能，核心功能包括：
* - 媒体文件管理：支持打开和关闭媒体文件
* - stream 提取：提取音频流和视频流
* - 异步读取：通过多线程实现音视频数据包的异步读取和发送
* - 回调机制：通过回调通知上层组件数据包已到达
* - stream 跳转（Seek）：快速跳转到视频播放位置
*/
static std::string err2str_(int e) {
    char b[AV_ERROR_MAX_STRING_SIZE];
    av_strerror(e, b, sizeof(b));
    return std::string(b);
}

void Demuxer::printErr(const char* where, int err) {
    std::cerr << where << " failed: " << err2str_(err) << "\n";
}


int Demuxer::open(const char* path) {
    int r = avformat_open_input(&fmt_, path, nullptr, nullptr);
    if (r < 0) {
        printErr("av_format_open_input", r);
        return r;
    }

    r = avformat_find_stream_info(fmt_, nullptr);
    if (r < 0) {
        printErr("avformat_find_stream_info", r);
        return r;
    }

    for (unsigned int i = 0; i < fmt_->nb_streams; ++i) {
        AVStream* st = fmt_->streams[i];
        if (st->codecpar->codec_type == AVMEDIA_TYPE_VIDEO && vidx_ < 0) vidx_ = (int)i;
        if (st->codecpar->codec_type == AVMEDIA_TYPE_AUDIO && aidx_ < 0) aidx_ = (int)i;
    }
    return 0;

}

void Demuxer::close() {
    if (fmt_) { avformat_close_input(&fmt_); }
    vidx_ = -1;
    aidx_ = -1;
}

int Demuxer::readInfo() {
    if (!fmt_) return -1;

    AVPacket* pkt = av_packet_alloc();
    if (!pkt) return -1;

    int r = 0, n = 0;
    while ((r = av_read_frame(fmt_, pkt)) >= 0) {
        AVStream* st = fmt_->streams[pkt->stream_index];
        const char* kind = av_get_media_type_string(st->codecpar->codec_type);

        double pts = ts2s(pkt->pts, st->time_base);
        double dts = ts2s(pkt->dts, st->time_base);

        std::cout << "[#" << pkt->stream_index << " " << (kind ? kind : "unknown") << "]"
            << " size=" << pkt->size
            << " pts=" << (pkt->pts == AV_NOPTS_VALUE ? -1 : pts)
            << " dts=" << (pkt->dts == AV_NOPTS_VALUE ? -1 : dts)
            << "\n";

        av_packet_unref(pkt);
    }
    av_packet_free(&pkt);
    if (r == AVERROR_EOF) r = 0;
    return r;
}

double Demuxer::ts2s(int64_t v, AVRational tb) {
    if (v == AV_NOPTS_VALUE) return -1.0;
    return v * av_q2d(tb); // 用每条流自己的 time_base
}

int main(int argc, char* argv[]) {
    if (argc < 2) { std::cerr << "usage: demux <input>\n"; 
    return -1; 
    }

    Demuxer d;
    if (int r = d.open(argv[1])) return -1;

    std::cout << "videoIndex=" << d.videoIndex()
        << " audioIndex=" << d.audioIndex() << "\n";

    d.readInfo();  
    return 0;
}