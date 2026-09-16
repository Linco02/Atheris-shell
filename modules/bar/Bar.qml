import Quickshell
import QtQuick
import qs.config
import qs.services
import "./components"

import qs.components
// import qs.modules.atheriscenter

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

    Item {
        anchors {
            verticalCenter: isHorizontal ? parent.verticalCenter : undefined
            horizontalCenter: isHorizontal ? undefined : parent.verticalCenter
        }
        height: root.height - Theme.padding.normal
        width: root.width

        RowContainer {
            anchors.left: parent.left
            leftPadding: Theme.padding.normal

            Power {}
            Workspace {}
            Taskbar {}
        }

        RowContainer {
            anchors.horizontalCenter: parent.horizontalCenter

            Clock {}
            Loader {
                active: STime.stopWatchCount > 0
                height: STime.stopWatchCount > 0
                    ? parent.height
                    : 0
                sourceComponent: StopWatch {}
            }
            Music {}
            Device {}
        }

        RowContainer {
            anchors.right: parent.right
            rightPadding: Theme.padding.normal

            Status {}
        }
    }

    component RowContainer : Row {
        height: root.height - Theme.padding.normal
        spacing: Theme.spacing.normal
    }
}