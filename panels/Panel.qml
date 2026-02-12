import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.components
import qs.settings
import qs.widgets

PanelWindow {
    id: root

    enum PanelSide { Top, Bottom, Left, Right }
    property bool isHorizontalPanel: ancorSide === Panel.PanelSide.Top || ancorSide === Panel.PanelSide.Bottom
    property bool isVerticalPanel: !isHorizontalPanel
    property bool isTop: ancorSide === Panel.PanelSide.Top

    property int panelHeight: height
    property int panelWidth: width
    property real radius: Style.radius2
    property real padding: Style.padding

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

    color: Style.panelColor

    function panelWidgets() {
        switch(ancorSide){
            case Panel.PanelSide.Top:
                return Settings.topPanel || {}
            case Panel.PanelSide.Bottom:
                return Settings.bottomPanel || {}
            case Panel.PanelSide.Left:
                return Settings.leftPanel || {}
            case Panel.PanelSide.Right:
                return Settings.rightPanel || {}
        }
    }

    Loader {
        anchors.fill: parent
        sourceComponent: isHorizontalPanel ? topBottom : leftRight
    }

    // topPanel та bottomPanel
    Component {
        id: topBottom
        Item {
            anchors.fill: parent
            Item {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                height: 30; width: leftTBRow.width
                RectBackground {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 20; width: leftTBRow.width
                    x: 10
                    
                    RowStyle1 {
                        id: leftTBRow
                        anchors.centerIn: parent

                        Repeater {
                            model: root.panelWidgets().topORleftSide || []
                            Loader {
                                source: modelData
                                onLoaded: {
                                    isVerticalPanel = Qt.binding(() => root.isVerticalPanel)
                                }
                            }
                        }
                    }
                }
            }

            Item {
                anchors.centerIn: parent
                height: 30; width: leftTBRow.width
                RectBackground {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 20; width: centerTBRow.width
                    x: 10
                    
                    RowStyle1 {
                        id: centerTBRow
                        anchors.centerIn: parent

                        Repeater {
                            model: root.panelWidgets().centerSide || []
                            Loader {
                                source: modelData
                                onLoaded: {
                                    isVerticalPanel = Qt.binding(() => root.isVerticalPanel)
                                }
                            }
                        }
                    }
                }
            }



            Item {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                height: 30; width: leftTBRow.width
                RectBackground {
                    anchors.verticalCenter: parent.verticalCenter
                    height: 20; width: rightTBRow.width
                    x: 10
                    
                    RowStyle1 {
                        id: rightTBRow
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }

                        Repeater {
                            model: root.panelWidgets().bottomORrightSide || []
                            Loader {
                                source: modelData
                                onLoaded: {
                                    isVerticalPanel = Qt.binding(() => root.isVerticalPanel)
                                }
                            }
                        }
                    }
                }
            }



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
        }
    }

    // leftPanel та RightPanel
    Component {
        id: leftRight
        Item {
            anchors.fill: parent

            Column {
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }

                Repeater {
                    model: root.panelWidgets().topORleftSide || []
                    Loader {
                        source: modelData
                        onLoaded: {
                            isVerticalPanel = Qt.binding(() => root.isVerticalPanel)
                        }
                    }
                }
            }

            Column {
                anchors.centerIn: parent

                Repeater {
                    model: root.panelWidgets().centerSide || []
                    Loader {
                        source: modelData
                        onLoaded: {
                            isVerticalPanel = Qt.binding(() => root.isVerticalPanel)
                        }
                    }
                }
            }

            Column {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }

                Repeater {
                    model: root.panelWidgets().rightPanel || []
                    Loader {
                        source: modelData
                        onLoaded: {
                            isVerticalPanel = Qt.binding(() => root.isVerticalPanel)
                        }
                    }
                }
            }
        }
    }
}