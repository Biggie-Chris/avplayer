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

	// ���ļ�
	int open(const char* path);

	// �鿴����Ƶ������
	int videoIndex() const { return vidx_; }
	int audioIndex() const { return aidx_; }

	// ��ȡ packet ����ӡ��Ϣ
	int readInfo();

	// �ر��ļ����ͷ���Դ
	void close();

private:
	int vidx_{-1};
	int aidx_{-1};

	AVFormatContext* fmt_{ nullptr }; // ����������
	
	static double ts2s(int64_t v, AVRational tb); // ʱ�������
	static void   printErr(const char* where, int err);

};