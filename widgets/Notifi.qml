import QtQuick
import Quickshell.Io
import Quickshell.Services.Notifications

Item {
    height: 200; width: 200

    NotificationServer {
        id: myNotificationServer
        
        onNotification: (n) => {
            // Примусово змушуємо сервер стежити за цим сповіщенням
            n.tracked = true; 
        }
    }

    Process {
        id: testNotifi
        // Додаємо затримку, щоб сповіщення точно встигло обробитися
        command: ["notify-send", "Hello", "This is a test notification"]
    }

    Column {
        anchors.fill: parent
        spacing: 10
        padding: 20

        Rectangle {
            width: 100; height: 40; color: "red"
            Text { anchors.centerIn: parent; text: "Надіслати"; color: "white" }
            MouseArea { anchors.fill: parent; onClicked: testNotifi.running = true }
        }

        // Відображення списку
        Repeater {
            // ВАЖЛИВО: використовуємо .values для доступу до масиву
            model: myNotificationServer.trackedNotifications.values

            delegate: Rectangle {
                width: 180; height: 50
                color: "lightgray"
                border.color: "gray"
                
                Text {
                    anchors.left: parent.left
                    text: modelData ? modelData.summary : "Порожньо"
                }
                Text {
                    anchors.right: parent.right
                    text: modelData ? modelData.appName : "Порожньо"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: dismiss()
                }
            }
        }
    }
}