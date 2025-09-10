#include "ControllerWidget.h"
#include <QHBoxLayout>
#include <QMessageBox>

ControllerWidget::ControllerWidget(QWidget* parent,
    std::shared_ptr<av::IPlayer> player)
    : QWidget(parent), m_player(std::move(player)) {
    auto* layout = new QHBoxLayout(this);

    m_buttonImport = new QPushButton("Import", this);
    m_buttonPlay = new QPushButton("Play", this);
    m_buttonExport = new QPushButton("Export", this);
    m_buttonVideoFilterFlipVertical = new QPushButton("Flip", this);
    m_buttonVideoFilterGray = new QPushButton("Gray", this);
    m_buttonVideoFilterInvert = new QPushButton("Invert", this);
    m_buttonVideoFilterSticker = new QPushButton("Sticker", this);

    layout->addWidget(m_buttonImport);
    layout->addWidget(m_buttonPlay);
    layout->addWidget(m_buttonExport);
    layout->addStretch();
    layout->addWidget(m_buttonVideoFilterFlipVertical);
    layout->addWidget(m_buttonVideoFilterGray);
    layout->addWidget(m_buttonVideoFilterInvert);
    layout->addWidget(m_buttonVideoFilterSticker);

    connect(m_buttonImport, &QPushButton::clicked, this, &ControllerWidget::onImportButtonClicked);
    connect(m_buttonPlay, &QPushButton::clicked, this, &ControllerWidget::onPlayButtonClicked);
    connect(m_buttonExport, &QPushButton::clicked, this, &ControllerWidget::onExportButtonClicked);
    connect(m_buttonVideoFilterFlipVertical, &QPushButton::clicked, this, &ControllerWidget::onVideoFilterFlipVerticalButtonClicked);
    connect(m_buttonVideoFilterGray, &QPushButton::clicked, this, &ControllerWidget::onVideoFilterGrayButtonClicked);
    connect(m_buttonVideoFilterInvert, &QPushButton::clicked, this, &ControllerWidget::onVideoFilterInvertButtonClicked);
    connect(m_buttonVideoFilterSticker, &QPushButton::clicked, this, &ControllerWidget::onVideoFilterStickerButtonClicked);
}

void ControllerWidget::onImportButtonClicked() {
    QMessageBox::information(this, "Controller", "Import clicked");
}
void ControllerWidget::onPlayButtonClicked() {
    QMessageBox::information(this, "Controller", "Play clicked");
}
void ControllerWidget::onExportButtonClicked() {
    QMessageBox::information(this, "Controller", "Export clicked");
}
void ControllerWidget::onVideoFilterFlipVerticalButtonClicked() {
    QMessageBox::information(this, "Controller", "Flip clicked");
}
void ControllerWidget::onVideoFilterGrayButtonClicked() {
    QMessageBox::information(this, "Controller", "Gray clicked");
}
void ControllerWidget::onVideoFilterInvertButtonClicked() {
    QMessageBox::information(this, "Controller", "Invert clicked");
}
void ControllerWidget::onVideoFilterStickerButtonClicked() {
    QMessageBox::information(this, "Controller", "Sticker clicked");
}