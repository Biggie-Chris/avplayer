#pragma once

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/avutil.h>
}

class Demuxer {
public:
	Demuxer() = default;
	~Demuxer() { close(); }
	Demuxer(const Demuxer&) = delete;
	Demuxer& operator=(const Demuxer&) = delete;

	// 打开文件
	int open(const char* path);

	// 查看音视频流索引
	int videoIndex() const { return vidx_; }
	int audioIndex() const { return aidx_; }

	// 读取 packet 并打印信息
	int readInfo();

	// 关闭文件并释放资源
	void close();

private:
	int vidx_{-1};
	int aidx_{-1};

	AVFormatContext* fmt_{ nullptr }; // 容器上下文
	
	static double ts2s(int64_t v, AVRational tb); // 时间戳→秒
	static void   printErr(const char* where, int err);

};