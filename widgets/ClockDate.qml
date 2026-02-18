import QtQuick
import qs.singletons
import qs.settings
import qs.components

RectForeground {
    id: clockDateWidget

    property string time: ""
    property string date: ""
    property string timeSimbol: ""
    property int monthTimeStart: 0
    property int monthTimeEnd: 0

    function mounthUpdate() {
        let month = parseInt(date.split("/")[1])
        
        if (month >= 2 && month <= 4) { // Весна (Березень - Травень)
            monthTimeStart = 6
            monthTimeEnd = 19
        } 
        else if (month >= 5 && month <= 7) { // Літо (Червень - Серпень)
            monthTimeStart = 5
            monthTimeEnd = 21
        } 
        else if (month >= 8 && month <= 10) { // Осінь (Вересень - Листопад)
            monthTimeStart = 7
            monthTimeEnd = 18
        } 
        else { // Зима (Грудень, Січень, Лютий)
            monthTimeStart = 8
            monthTimeEnd = 16
        }
    }

    function timeSimbolUpdate() {
        let hours = parseInt(time.split(":")[0])

        if ( hours >= monthTimeStart && hours <= monthTimeEnd ) {
            timeSimbol = ""
        } else {
            timeSimbol = ""
        }
    }

    Connections {
        target: Time
        function onTime(data) {
            time = data
        }
        function onDate(data) {
            date = data
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: Style.spacing

        TextStyle1 {
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: clockDateWidget.height / 2
            text: timeSimbol
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: Style.spacing

            TextStyle1 {
                anchors.horizontalCenter: parent.horizontalCenter
                text: date
            }

            TextStyle1 {
                anchors.horizontalCenter: parent.horizontalCenter
                text: time
            }
        }
    }


    Component.onCompleted: {
        Time.clockUpdate()
        mounthUpdate()
        timeSimbolUpdate()
    }
}
