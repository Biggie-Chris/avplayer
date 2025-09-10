#pragma once

#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <memory>

namespace av {
    class OpenGLView;
    struct IPlayer;
}  // namespace av

class PlayerWidget final : public QWidget {
    Q_OBJECT
public:
    explicit PlayerWidget(QWidget* parent, std::shared_ptr<av::IPlayer> player);
    ~PlayerWidget() override;

private:
    av::OpenGLView* m_openGLView{ nullptr };
    std::shared_ptr<av::IPlayer> m_player;
};
