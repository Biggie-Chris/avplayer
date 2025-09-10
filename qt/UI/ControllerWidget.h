#pragma once

#include <memory> 
#include <qlabel.h>
#include <qpushbutton.h>
#include <qwidget.h>

namespace av {
	struct IPlayer;
}

class ControllerWidget : public QWidget {
	Q_OBJECT
public:
	explicit ControllerWidget(QWidget* parent,
		std::shared_ptr<av::IPlayer> player);
	~ControllerWidget() override = default;

private slots:
	void onImportButtonClicked();
	void onPlayButtonClicked();
	void onExportButtonClicked();
	void onVideoFilterFlipVerticalButtonClicked();
	void onVideoFilterGrayButtonClicked();
	void onVideoFilterInvertButtonClicked();
	void onVideoFilterStickerButtonClicked();

private:
	QPushButton* m_buttonImport{ nullptr };
	QPushButton* m_buttonPlay{ nullptr };
	QPushButton* m_buttonExport{ nullptr };
	QPushButton* m_buttonVideoFilterFlipVertical{ nullptr };
	QPushButton* m_buttonVideoFilterGray{ nullptr };
	QPushButton* m_buttonVideoFilterInvert{ nullptr };
	QPushButton* m_buttonVideoFilterSticker{ nullptr };

	std::shared_ptr<av::IPlayer> m_player;
};