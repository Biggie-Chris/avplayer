#include <QApplication>
#include <QSurfaceFormat>
#include <QTranslator>
#include "MainWindow.h"

int main(int argc, char* argv[]) {
    // ���ù���OpenGL����������
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    // ����OpenGL Surface��ʽ
    QSurfaceFormat fmt;
    fmt.setDepthBufferSize(24);                   // ������Ȼ�������С
    fmt.setVersion(3, 3);                         // ����OpenGL�汾
    fmt.setProfile(QSurfaceFormat::CoreProfile);  // ����OpenGL�����ļ�
    QSurfaceFormat::setDefaultFormat(fmt);        // ����Ĭ�ϸ�ʽ

    QApplication a(argc, argv);  // ����QApplication����
    MainWindow w;                // ���������ڶ���
    w.show();                    // ��ʾ������

    return a.exec();  // ����Ӧ�ó����¼�ѭ��
}
