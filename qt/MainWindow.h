#pragma once
#include <QWidget>
#include "UI/PlayerWidget.h"
#include "UI/ControllerWidget.h"

class QSlider;
class QVBoxLayout;
class QResizeEvent;
class QMouseEvent;

class MainWindow : public QWidget {
public:
    explicit MainWindow(QWidget* parent = nullptr);
    ~MainWindow();

private:
    void onSliderMoved(int value);      // ��Ӧ�������ƶ�

    // ��������Щ�¼�����ɾ����Ӧ������ʵ��
protected:
    void resizeEvent(QResizeEvent* event) override;
    void mousePressEvent(QMouseEvent* event) override;
    void mouseMoveEvent(QMouseEvent* event) override;
    void mouseReleaseEvent(QMouseEvent* event) override;
    void mouseDoubleClickEvent(QMouseEvent* event) override;

private:
    std::shared_ptr<av::IPlayer> m_player;
    PlayerWidget* m_playerWidget{ nullptr };
    ControllerWidget* m_controllerWidget{ nullptr };
    QSlider* m_progressSlider{ nullptr };
};