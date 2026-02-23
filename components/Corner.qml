import QtQuick
// import QtQuick.Shapes
// import qs.settings

// Item {
//     id: root
//     height: parent.height; width: height

//     enum CornerSide { TopLeft, TopRight, BottomLeft, BottomRight }
//     property bool isLeft: ancorSide === Corner.CornerSide.TopLeft || ancorSide === Corner.CornerSide.BottomLeft
//     property bool isTop: ancorSide === Corner.CornerSide.TopLeft || ancorSide === Corner.CornerSide.TopRight
//     // property bool isTop: false
//     property real radius: parent.height

//     anchors {
//         left: (
//             ancorSide === Corner.CornerSide.TopLeft ||
//             ancorSide === Corner.CornerSide.BottomLeft
//         ) ? parent.left : undefined
//         right: (
//             ancorSide === Corner.CornerSide.TopRight ||
//             ancorSide === Corner.CornerSide.BottomRight
//         ) ? parent.right : undefined
//     }

//     Shape {
//         height: parent.height; width: parent.width
//         anchors.fill: parent
//         rotation: isTop ? 0 : isLeft ? 270 : 90
//         ShapePath {
//             strokeWidth: 0
//             fillColor: "black"
//             startY: radius
//             startX: isLeft ? 0 : radius
//             PathArc {
//                 y: 0; x: isLeft ? radius : 0
//                 radiusX: radius; radiusY: radius
//                 direction: isLeft ? PathArc.Clockwise : PathArc.Counterclockwise
//                 useLargeArc: false
//             }
//             PathLine { y: 0; x: isLeft ? 0 : radius }
//             PathLine { y: radius; x: isLeft ? 0 : radius }
//         }
//     }
// }