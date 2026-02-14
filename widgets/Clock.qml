import QtQuick
import qs.singletons
import qs.settings
import qs.components

import Quickshell

RectForeground {
    id: clockwidget
    height: panelHeight - Style.padding2x; width: clockText.width + Style.padding * 2

    property string time: ""

    Connections {
        target: Time
        function onDate(data) {
            time = data
        }
    }

    TextStyle2 {
        id: clockText
        anchors.centerIn: parent
        text: time
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: clockwidget.color = Style.activeColor
        onExited: clockwidget.color = Style.foreGround
        onClicked: {
            jumpMenu.visible = true
            jumpMenu.percent = 1
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    Connections {
        target: jumpMenu

        function onClose() {
            perfomanceWidget.active = false
        }
        function onOpen() {
            perfomanceWidget.active = true
        }
    }

    JumpMenu {
        id: jumpMenu
        implicitHeight: perfomanceWidget.height;
        implicitWidth: perfomanceWidget.width + radius2 * 2


        Perfomance {
            id: perfomanceWidget
        }
    }
}