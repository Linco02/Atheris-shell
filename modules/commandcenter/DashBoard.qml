import QtQuick
import QtQuick.Controls
import qs.components
import qs.components.shapes
import qs.components.animations
import qs.components.containers
import qs.config
import "./modules"

Column {
    id: root
    spacing: space

    property int space: Global.spacing.normal
    property int gap: 60

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Global.spacing.large
   
        ButtonOwn {
            btnText: "󰼄"
            onClicked: Global.dashboardModul = "music"
        }
        ButtonOwn {
            btnText: "󰨝"
            onClicked: Global.dashboardModul = "dash"
        }
        ButtonOwn {
            btnText: ""
            onClicked: Global.dashboardModul = "performance"
        }
    }

    RectForeground {
        anchors.horizontalCenter: parent.horizontalCenter
        height: 2
        width: widgetRow.width
    }

    Rect {
        id: widgetRow
        anchors.horizontalCenter: parent.horizontalCenter
        height: dash.height; width: dash.width
        clip: true
        state: Global.dashboardModul

        Row {
            id: pages
            spacing: gap
            x: 0
            
            Music { id: music }
            Dash { id: dash }
            Perfomance { id: performance }

            Behavior on x { NumberAnim { } }
        }

        states: [
            State {
                name: "music"
                PropertyChanges {
                    target: widgetRow
                    height: music.height; width: music.width
                }
                PropertyChanges { target: pages; x: 0 }
            },
            State {
                name: "dash"
                PropertyChanges {
                    target: widgetRow
                    height: dash.height; width: dash.width
                }
                PropertyChanges { target: pages; x: - gap - music.width }
            },
            State {
                name: "performance"
                PropertyChanges {
                    target: widgetRow
                    height: performance.height; width: performance.width
                }
                PropertyChanges { target: pages; x: - gap * 2 - music.width - dash.width }
            }
        ]
    }

    component ButtonOwn: Item {
        height: 40; width: height

        property string btnText: ""
        signal clicked()

        TextStyledH {
            anchors.centerIn: parent
            text: btnText
        }
        TapHandler { onTapped: clicked() }
    }
}