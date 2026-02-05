import QtQuick
import Quickshell
import qs.singles
import qs.widgets

PanelWindow {
    id: root
    enum PanelSide { Top, Bottom, Left, Right }

    // Component { id: clockComp; Clock {} }

    // property var topPanel: ({
    //     topORleftSide: [ ],
    //     centerSide: [ clockComp ],
    //     bottomORrightmSide: [ ]
    // })

    anchors {
        top: (
            ancorSide === Panel.PanelSide.Top ||
            ancorSide === Panel.PanelSide.Left ||
            ancorSide === Panel.PanelSide.Right
        ) ? true : false
        bottom: (
            ancorSide === Panel.PanelSide.Bottom ||
            ancorSide === Panel.PanelSide.Left ||
            ancorSide === Panel.PanelSide.Right
        ) ? true : false
        left: (
            ancorSide === Panel.PanelSide.Top ||
            ancorSide === Panel.PanelSide.Bottom ||
            ancorSide === Panel.PanelSide.Left
        ) ? true : false
        right: (
            ancorSide === Panel.PanelSide.Top ||
            ancorSide === Panel.PanelSide.Bottom ||
            ancorSide === Panel.PanelSide.Right
        ) ? true : false
    }

    implicitHeight: {
        ancorSide === Panel.PanelSide.Top ? Style.topPanel :
        ancorSide === Panel.PanelSide.Bottom ? Style.bottomPanel : 0
    }
    implicitWidth: {
        ancorSide === Panel.PanelSide.Left ? Style.leftPanel :
        ancorSide === Panel.PanelSide.Right ? Style.rightPanel : 0
    }

    color: Style.backGround

    Row {
        anchors.centerIn: parent
        Repeater {
            model: PanelSettings.topPanel.centerSide

            Loader {
                sourceComponent: modelData
            }
        }
    }

}