import QtQuick
import Quickshell
import qs.components
import qs.components.shapes
import qs.config
import qs.services

RectForeground {
    height: parent.height; width: networkText.width + Global.padding.normal
    
    readonly property string currentNetworkSimbol: NetworkServices.currentNetworkSimbol

    TextStyledH {
        id: networkText
        anchors.centerIn: parent
        text: currentNetworkSimbol
    }
}