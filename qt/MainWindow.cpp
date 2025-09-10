#include "MainWindow.h"
#include "UI/ControllerWidget.h"
#include "UI/PlayerWidget.h"

#include <QFrame>
#include <QMouseEvent>
#include <QResizeEvent>
#include <QSlider>
#include <QVBoxLayout>

MainWindow::MainWindow(QWidget* parent) : QWidget(parent) {
    // ������
    auto* vbox = new QVBoxLayout(this);
    vbox->setContentsMargins(0, 0, 0, 0);
    setLayout(vbox);

    // ���������� PlayerWidget ���أ��ڲ�������ռλ QLabel��
    m_playerWidget = new PlayerWidget(this, m_player);
    vbox->addWidget(m_playerWidget, /*stretch*/1);

    // ������
    m_progressSlider = new QSlider(Qt::Horizontal, this);
    m_progressSlider->setRange(0, 1000);
    m_progressSlider->setValue(0);
    connect(m_progressSlider, &QSlider::sliderMoved,
        this, &MainWindow::onSliderMoved);
    vbox->addWidget(m_progressSlider);

    // ������������/����/����/�˾���ť��
    m_controllerWidget = new ControllerWidget(this, m_player);
    vbox->addWidget(m_controllerWidget);

    setMinimumSize(800, 450);
}

MainWindow::~MainWindow() = default;

void MainWindow::onSliderMoved(int value) {
    // ��Сʾ����������ʵ Seek ����
    Q_UNUSED(value);
}

// �ߴ�仯
void MainWindow::resizeEvent(QResizeEvent* event)
{
    QWidget::resizeEvent(event); // ����������Ϊ
    // TODO: ��Ҫʱ��������Լ��Ĳ���/��ͼ�����߼�
}

// ��갴��
void MainWindow::mousePressEvent(QMouseEvent* event)
{
    QWidget::mousePressEvent(event);
}

// ����ƶ�
void MainWindow::mouseMoveEvent(QMouseEvent* event)
{
    QWidget::mouseMoveEvent(event);
}

// ����ͷ�
void MainWindow::mouseReleaseEvent(QMouseEvent* event)
{
    QWidget::mouseReleaseEvent(event);
}

// ���˫��
void MainWindow::mouseDoubleClickEvent(QMouseEvent* event)
{
    QWidget::mouseDoubleClickEvent(event);
}