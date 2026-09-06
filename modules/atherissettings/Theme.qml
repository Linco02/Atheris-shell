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

    RectForeground {
        height: wallpaperSettings.height; width: parent.width

        ColumnStyled {
            id: wallpaperSettings
            width: parent.width
            padding: Style.padding.large

            ButtonLabelToggle {
                text: "Шпалери"
                // text: STranslations.tr(modelData.label)
                // isActive: Settings[modelData.settingKey]
                // onClicked: Settings[modelData.settingKey] = !Settings[modelData.settingKey]
            }
            ButtonLabelToggle {
                text: "Випадкові шпалери при увімкнені"
                // text: STranslations.tr(modelData.label)
                // isActive: Settings[modelData.settingKey]
                // onClicked: Settings[modelData.settingKey] = !Settings[modelData.settingKey]
            }
        }
    }

    RectClip {
        height: 400; width: parent.width

        RectForeground {anchors.fill: parent}

        SmartMediaList {
            id: wallpaperList
            model: SWallpaper.wallpapers
            imageHeight: 120
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
        height: palitSettings.height; width: parent.width

        ColumnStyled {
            id: palitSettings
            width: parent.width
            padding: Style.padding.large

            Repeater {
                model: [
                    {label: "palette_shell", settingKey: "palitShellOn"},
                    {label: "palette_openrgb", settingKey: "palitOpenrgbOn"},
                    {label: "palette_pywalfox", settingKey: "palitPywalFoxOn"},
                    {label: "palette_kitty", settingKey: "palitKittyOn"},
                    {label: "palette_qt6ct", settingKey: "palitqt6ctOn"},
                ]

                delegate: ButtonLabelToggle {
                    text: STranslations.tr(modelData.label)
                    isActive: Settings[modelData.settingKey]
                    onClicked: Settings[modelData.settingKey] = !Settings[modelData.settingKey]
                }
            }
        }
    }
}