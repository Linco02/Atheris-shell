import QtQuick
import "./widgets"

Item {
    anchors.fill: parent

    Clock1 {
        y: parent.height / 8
        x: (parent.width - width) / 2 + parent.width / 3
    }
}