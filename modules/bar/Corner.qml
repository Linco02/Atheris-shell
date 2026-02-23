import QtQuick

Item {}
    // PanelWindow {
    //     id: leftCorner
    //     anchors {
    //         top: parent.top
    //         left: parent.top
    //     }
    //     implicitHeight: radius; implicitWidth: radius
    //     color: "transparent"

    //     Shape {
    //         height: parent.height; width: parent.width
    //         anchors.fill: parent
    //         ShapePath {
    //             strokeWidth: 0
    //             fillColor: Style.backGround
    //             startY: radius; startX: 0
    //             PathArc {
    //                 y: 0; x: radius
    //                 radiusX: radius; radiusY: radius
    //                 useLargeArc: false
    //             }
    //             PathLine { y: 0; x: 0; }
    //             PathLine { y: radius; x: 0 }
    //         }
    //     }
    // }

    // PanelWindow {
    //     id: rightCorner
    //     anchors {
    //         top: parent.bottom
    //         right: parent.right
    //     }
    //     implicitHeight: radius; implicitWidth: radius
    //     color: "transparent"

    //     Shape {
    //         height: parent.height; width: parent.width
    //         anchors.fill: parent
    //         ShapePath {
    //             strokeWidth: 0
    //             fillColor: Style.backGround
    //             startY: radius; startX: radius
    //             PathArc {
    //                 y: 0; x: 0
    //                 radiusX: radius; radiusY: radius
    //                 direction: PathArc.Counterclockwise
    //                 useLargeArc: false
    //             }
    //             PathLine { y: 0; x: radius }
    //             PathLine { y: radius; x: radius }
    //         }
    //     }
    // }