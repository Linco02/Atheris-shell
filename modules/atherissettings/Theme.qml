import QtQuick
import QtQuick.Layouts
import QtMultimedia
import qs.core
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.modules
import qs.components.controls
import qs.components.containers
import qs.components.animations

ColumnStyled {
    id: root
    anchors.fill: parent

    RowStyled {
        id: wallpaperMonitors
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: 1
            delegate: RectClip {
                height: 200; width: height / 9 * 16
                border {
                    width: 4
                    color: Theme.active

                    Behavior on color{NumberAnim{}}
                }

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    source: {
                        const format = SMedia.toFormat(SWallpaper.wallpaper)
                        if (format === "image") return SWallpaper.wallpaper
                        else SWallpaper.wallpaperThumbnail
                    }
                }
            }
        }
    }
    
    TextStyled {
        leftPadding: Style.padding.large
        text: STranslations.tr("theme_wallpaper_title")
    }

    RectClip {
        height: 400; width: parent.width

        RectForeground {anchors.fill: parent}

        SmartMediaList {
            id: wallpaperList
            model: SWallpaper.wallpapers
            onClicked: pathMedia => {
                if (UIState.isWallpaperChange) SWallpaper.wallpaperChange(pathMedia)
            }
        }
    }

    TextStyled {
        leftPadding: Style.padding.large
        text: STranslations.tr("theme_palit_title")
    }

    RectForeground {
        id: settingsContainer
        height: palitSettings.height; width: parent.width

        ColumnStyled {
            id: palitSettings
            width: parent.width
            padding: Style.padding.large

            LabelButton {
                text: STranslations.tr("palette_shell")
                isActive: Settings.palitShellOn
                onClicked: Settings.palitShellOn = !Settings.palitShellOn
            }

            LabelButton {
                text: STranslations.tr("palette_openrgb")
                isActive: Settings.palitOpenrgbOn
                onClicked: Settings.palitOpenrgbOn = !Settings.palitOpenrgbOn
            }

            LabelButton {
                text: STranslations.tr("palette_pywalfox")
                isActive: Settings.palitPywalFoxOn
                onClicked: Settings.palitPywalFoxOn = !Settings.palitPywalFoxOn
            }

            LabelButton {
                text: STranslations.tr("palette_kitty")
                isActive: Settings.palitKittyOn
                onClicked: Settings.palitKittyOn = !Settings.palitKittyOn
            }

            LabelButton {
                text: STranslations.tr("palette_qt6ct")
                isActive: Settings.palitqt6ctOn
                onClicked: Settings.palitqt6ctOn = !Settings.palitqt6ctOn
            }
        }
    }

    component LabelButton: Item {
        id: btn
        height: label.height; width: parent.width - Style.padding.large * 2

        property alias text: label.text
        property alias isActive: toggle.isActive

        signal clicked()

        TextStyledB {
            id: label
            anchors {
                left: parent.left
                leftMargin: Style.padding.normal
            }
            width: parent.width - toggle.width - Style.padding.large
        }

        ButtonToggle {
            id: toggle
            anchors {
                right: parent.right
                // rightMargin: Style.padding.large
            }
            height: label.height
            onClicked: btn.clicked()
        }
    }
}