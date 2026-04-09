import QtQuick
import QtQuick.Layouts
// import qs.components
import qs.components.shapes
import qs.components.popups
// import qs.components.controls
import qs.components.containers
import qs.config
// import qs.services
import "./modules"

PopFade {
    id: root
    containerH: controlCenterContainer.height
    containerW: controlCenterContainer.width
    positionX: panel.width - root.width - Global.padding.normal
    isOpen: Global.isControlCenterOpen
    onClosedPop: Global.isControlCenterOpen = false
    isLeft: false

    property int brickH: 40
    property int brickBH: 60

    GridLayout {
        id: controlCenterContainer
        width: brickBH * 8
        columns: 2
        rowSpacing: Global.spacing.normal; columnSpacing: rowSpacing

        Top { Layout.columnSpan: 2; Layout.fillWidth: true; height: brickH }
        Sound { Layout.columnSpan: 2; Layout.fillWidth: true; height: brickH }
        Brightness { Layout.columnSpan: 2; Layout.fillWidth: true; height: brickH }
        Wifi { Layout.columnSpan: 1; Layout.fillWidth: true; height: brickBH }
        Bluetooth { Layout.columnSpan: 1; Layout.fillWidth: true; height: brickBH }
        PowerMode { Layout.columnSpan: 1; Layout.fillWidth: true; height: brickBH }
        Disturb { Layout.columnSpan: 1; Layout.fillWidth: true; height: brickBH }
        Airplane { Layout.columnSpan: 1; Layout.fillWidth: true; height: brickBH }
        ThemeMod { Layout.columnSpan: 1; Layout.fillWidth: true; height: brickBH }
        Notifi { Layout.columnSpan: 2; Layout.fillWidth: true; height: 300 }
    }
}