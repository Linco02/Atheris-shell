import QtQuick
import qs.components

Item {
    id: root

    property string text: ""
    property int spacing: 0

    signal pClicked()
    signal mClicked()

    TextStyled {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        text: parent.text
    }

    ButtonStyled {
        anchors {
            right: minusButton.left
            rightMargin: root.spacing
        }
        height: parent.height; width: height
        text: "+"
        onClicked: pClicked()
    }

    ButtonStyled {
        id: minusButton
        anchors.right: parent.right
        height: parent.height; width: height
        text: "-"
        onClicked: mClicked()
    }
}