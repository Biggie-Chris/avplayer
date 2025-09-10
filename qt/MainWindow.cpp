#include "MainWindow.h"
#include "UI/ControllerWidget.h"
#include "UI/PlayerWidget.h"

#include <QFrame>
#include <QMouseEvent>
#include <QResizeEvent>
#include <QSlider>
#include <QVBoxLayout>

MainWindow::MainWindow(QWidget* parent) : QWidget(parent) {
    // 主布局
    auto* vbox = new QVBoxLayout(this);
    vbox->setContentsMargins(0, 0, 0, 0);
    setLayout(vbox);

    // 播放区域（由 PlayerWidget 承载；内部现在是占位 QLabel）
    m_playerWidget = new PlayerWidget(this, m_player);
    vbox->addWidget(m_playerWidget, /*stretch*/1);

    // 进度条
    m_progressSlider = new QSlider(Qt::Horizontal, this);
    m_progressSlider->setRange(0, 1000);
    m_progressSlider->setValue(0);
    connect(m_progressSlider, &QSlider::sliderMoved,
        this, &MainWindow::onSliderMoved);
    vbox->addWidget(m_progressSlider);

    // 控制条（导入/播放/导出/滤镜按钮）
    m_controllerWidget = new ControllerWidget(this, m_player);
    vbox->addWidget(m_controllerWidget);

    setMinimumSize(800, 450);
}

MainWindow::~MainWindow() = default;

void MainWindow::onSliderMoved(int value) {
    // 最小示例：暂无真实 Seek 调用
    Q_UNUSED(value);
}

// 尺寸变化
void MainWindow::resizeEvent(QResizeEvent* event)
{
    QWidget::resizeEvent(event); // 保留基类行为
    // TODO: 需要时在这里加自己的布局/视图更新逻辑
}

// 鼠标按下
void MainWindow::mousePressEvent(QMouseEvent* event)
{
    QWidget::mousePressEvent(event);
}

// 鼠标移动
void MainWindow::mouseMoveEvent(QMouseEvent* event)
{
    QWidget::mouseMoveEvent(event);
}

// 鼠标释放
void MainWindow::mouseReleaseEvent(QMouseEvent* event)
{
    QWidget::mouseReleaseEvent(event);
}

// 鼠标双击
void MainWindow::mouseDoubleClickEvent(QMouseEvent* event)
{
    QWidget::mouseDoubleClickEvent(event);
}