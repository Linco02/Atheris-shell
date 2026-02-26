import QtQuick
import qs.config
import qs.components.shapes
import qs.components

Item {
    implicitHeight: musicPage.height
    implicitWidth: musicPage.width

    RectForeground {
        id: musicPage
        anchors.centerIn: parent
        implicitHeight: 500
        implicitWidth: 700
    }

    // Column {
    //     anchors.centerIn: parent
    //     spacing: 20

    //     Repeater {
    //         model: Mpris.players
    //         delegate: Rectangle {
    //             height: 200; width: 300
    //             color: "gray"

    //             Column {
    //                 Text {
    //                     text: modelData.trackArtist
    //                 }
                    
    //                 Text {
    //                     text: modelData.identity
    //                 }

    //                 Text {
    //                     text: modelData.volume
    //                 }

    //                 Image {
    //                     // anchors.fill: parent
    //                     height: 64; width: 64
    //                     source: modelData.trackArtUrl
    //                     fillMode: Image.PreserveAspectCrop
    //                 }
    //             }
    //         }
    //     }
    // }
}