#include "PlayerWidget.h"
#include <QLabel>
#include <QVBoxLayout>

PlayerWidget::PlayerWidget(QWidget* parent, std::shared_ptr<av::IPlayer> player)
    : QWidget(parent), m_player(std::move(player)) {
    auto* layout = new QVBoxLayout(this);

    // 占位：实际项目里应当用 OpenGLView 或播放器界面
    auto* placeholder = new QLabel("PlayerWidget (占位)", this);
    placeholder->setAlignment(Qt::AlignCenter);

    layout->addWidget(placeholder);
    setLayout(layout);
}

PlayerWidget::~PlayerWidget() = default;
