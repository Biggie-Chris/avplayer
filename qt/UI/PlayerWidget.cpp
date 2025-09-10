#include "PlayerWidget.h"
#include <QLabel>
#include <QVBoxLayout>

PlayerWidget::PlayerWidget(QWidget* parent, std::shared_ptr<av::IPlayer> player)
    : QWidget(parent), m_player(std::move(player)) {
    auto* layout = new QVBoxLayout(this);

    // ռλ��ʵ����Ŀ��Ӧ���� OpenGLView �򲥷�������
    auto* placeholder = new QLabel("PlayerWidget (ռλ)", this);
    placeholder->setAlignment(Qt::AlignCenter);

    layout->addWidget(placeholder);
    setLayout(layout);
}

PlayerWidget::~PlayerWidget() = default;
