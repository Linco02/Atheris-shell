import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components.containers
import "./components"

import qs.components

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

    property string barPosition: Settings.barPosition || "top"
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
        // Taskbar {isHorizontal: root.isHorizontal}
    }

    GridRotable {
        anchors.centerIn: parent
        isHorizontal: root.isHorizontal

        Clock {isHorizontal: root.isHorizontal}
        // Loader {
        //     active: STime.stopWatchCount > 0
        //     height: STime.stopWatchCount > 0
        //         ? parent.height
        //         : 0
        //     sourceComponent: StopWatch {}
        // }
        // Music {isHorizontal: root.isHorizontal}
        // Device {isHorizontal: root.isHorizontal}
    }

    GridRotable {
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: verticalMargine
            rightMargin: horizontalMargine
        }
        isHorizontal: root.isHorizontal

        // Status {isHorizontal: root.isHorizontal}
    }

    component BarGrid: GridRotable {
        isHorizontal: root.isHorizontal
        topPadding: isHorizontal ? Theme.stock.small / 2 : 0
        bottomPadding: isHorizontal ? Theme.stock.small / 2 : 0
        leftPadding: isHorizontal ? 0 : Theme.stock.small / 2
        rightPadding: isHorizontal ? 0 : Theme.stock.small / 2
    }
}