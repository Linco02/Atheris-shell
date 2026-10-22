import QtQuick.Effects
import qs.components
import qs.config
import qs.services

SmartView {
    anchors.fill: parent
    content: SWallpaper.wallpaper
    isPlay: UIState.session.isLock

    layer.enabled: true
    layer.effect: MultiEffect {
        blurEnabled: true
        blurMax: 32
        blur: 2.0
    }
}