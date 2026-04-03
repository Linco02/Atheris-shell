import QtQuick
import qs.components.controls
import qs.config
// import qs.modules.dashboard
import qs.services

ButtonStyled {
    height: root.height - Global.padding.normal
    text: "test"
    onClicked: console.log("yes")

    Connections {
        target: Time
        function onTime(data) {
            text = data
        }
    }
}

//     // DashBoard {
//     //     id: controlCenter
//     // }


//     //     onClicked: {
//     //         let target = "dashboard"
//     //         GlobalStates.isDashboardOpen = (GlobalStates.isDashboardModule === target) ? !GlobalStates.isDashboardOpen : true
//     //         GlobalStates.isDashboardModule = target
//     //     }