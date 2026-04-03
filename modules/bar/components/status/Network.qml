import QtQuick
import Quickshell
import qs.components
import qs.services

Item {
    height: parent.height; width: networkText.width
    
    readonly property string currentNetworkSimbol: NetworkServices.currentNetworkSimbol

    TextStyledH {
        id: networkText
        anchors.centerIn: parent
        text: currentNetworkSimbol
    }
}