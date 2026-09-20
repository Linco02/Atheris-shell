import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.services
import qs.components
import qs.components.containers
import "./components"


PanelWindow {
    id: root
    anchors {
        left: barPosition !== "right"
        right: barPosition !== "left"
        top: barPosition !== "bottom"
        bottom: barPosition !== "top"
    }
    implicitHeight: isHorizontal ? Theme.barWidth : 0
    implicitWidth: isHorizontal ? 0 : Theme.barWidth
    focusable: UIState.isAtherisCenterOpen || UIState.isAuthenficatorOpen
    color: Theme.colors.surface

    property string barPosition: Settings.barPosition ?? "top"
    property bool isHorizontal: (barPosition === "top" || barPosition === "bottom")
    property int horizontalMargine: isHorizontal ? Theme.margine.large : 0
    property int verticalMargine: !isHorizontal ? Theme.margine.large : 0

    BarGrid {
        anchors {
            top: parent.top
            left: parent.left
            topMargin: verticalMargine
            leftMargin: horizontalMargine
        }

        Power {}
        Workspace {isHorizontal: root.isHorizontal}
        Taskbar {isHorizontal: root.isHorizontal}
    }

    BarGrid {
        anchors.centerIn: parent

        Clock {isHorizontal: root.isHorizontal}
        StopWatch {isHorizontal: root.isHorizontal}
        Music {isHorizontal: root.isHorizontal}
        Device {isHorizontal: root.isHorizontal}
    }

    BarGrid {
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: verticalMargine
            rightMargin: horizontalMargine
        }

        Status {isHorizontal: root.isHorizontal}
    }

    component BarGrid: GridRotable {
        isHorizontal: root.isHorizontal
        topPadding: isHorizontal ? Theme.stock.small / 2 : 0
        bottomPadding: isHorizontal ? Theme.stock.small / 2 : 0
        leftPadding: isHorizontal ? 0 : Theme.stock.small / 2
        rightPadding: isHorizontal ? 0 : Theme.stock.small / 2
    }
}