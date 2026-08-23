import Quickshell
import QtQuick
import qs.config
import qs.services
import "./components"

import qs.modules.atheriscenter

PanelWindow {
    id: root
    anchors {
        left: barPosition !== "right"
        right: barPosition !== "left"
        top: barPosition !== "bottom"
        bottom: barPosition !== "top"
    }
    implicitHeight: isHorizontal ? Style.barWidth : 0
    implicitWidth: isHorizontal ? 0 : Style.barWidth
    focusable: UIState.isAtherisCenterOpen || UIState.isAuthenficatorOpen
    color: Theme.surface

    property string barPosition: Settings.barPosition || "top"
    property bool isHorizontal: (barPosition === "top" || barPosition === "bottom")

    Item {
        anchors {
            verticalCenter: isHorizontal ? parent.verticalCenter : undefined
            horizontalCenter: isHorizontal ? undefined : parent.verticalCenter
        }
        height: root.height - Style.padding.normal
        width: root.width

        RowContainer {
            anchors.left: parent.left
            leftPadding: Style.padding.normal

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
            rightPadding: Style.padding.normal

            Status {}
        }
    }

    component RowContainer : Row {
        height: root.height - Style.padding.normal
        spacing: Style.spacing.normal
    }
}