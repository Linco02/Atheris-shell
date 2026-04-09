import QtQuick.Layouts
import qs.config
import "./modules"


GridLayout {
    id: root
    anchors.fill: parent
    columns: 2
    rowSpacing: Global.spacing.normal; columnSpacing: rowSpacing

    property int brickH: 40
    property int brickBH: 60

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