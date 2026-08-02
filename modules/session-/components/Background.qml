import QtQuick.Effects
import qs.components
import qs.config

SmartView {
    anchors.fill: parent
    content: Global.wallpaperCurrent
    isPlay: Global.isSessionLock

    layer.enabled: true
    layer.effect: MultiEffect {
        blurEnabled: true
        blurMax: 32
        blur: 1.0
    }
}