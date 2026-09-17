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

    property int componentsHeight: Theme.barWidth - (!Theme.theme.useAngledShapes ? Theme.padding.small * 2 : 0)

    GridLayout {
        anchors.fill: parent
        columns: isHorizontal ? 3 : 1
        rows: isHorizontal ? 1 : 3

        RowStyled {
            Layout.alignment: isHorizontal ? Qt.AlignLeft : Qt.AlignTop
            Layout.leftMargin: isHorizontal ? Theme.margine.large : 0
            Layout.topMargin: isHorizontal ? 0 : Theme.margine.large

            Power {height: componentsHeight}
            Workspace {height: componentsHeight}
            Taskbar {height: componentsHeight}
        }

        RowStyled {
            Layout.alignment: !isHorizontal ? Qt.AlignHCenter : Qt.AlignVCenter

            Clock {height: componentsHeight}
            Loader {
                active: STime.stopWatchCount > 0
                height: STime.stopWatchCount > 0
                    ? parent.height
                    : 0
                sourceComponent: StopWatch {}
            }
            Music {height: componentsHeight}
            Device {height: componentsHeight}
        }

        RowStyled {
            Layout.alignment: root.isHorizontal ? Qt.AlignRight : Qt.AlignBottom
            Layout.rightMargin: isHorizontal ? Theme.margine.large : 0
            Layout.bottomMargin: isHorizontal ? 0 : Theme.margine.large

            Status {height: componentsHeight}
        }
    }

    component RowContainer : Row {
        // anchors.verticalCenter: parent.verticalCenter
        height: root.height - Theme.padding.normal
        spacing: Theme.spacing.normal
    }
}