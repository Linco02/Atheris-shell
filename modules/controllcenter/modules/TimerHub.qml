import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.components.containers

RectForeground {
    id: root
    height: 200; width: parent.width

    ColumnStyled {
        ButtonMutable {
            height: 40; width: root.width
            buttons: UIState.timerHubModules
            buttonsNames: ["Таймер", "Секундомір", "Будильник"]
            activeButton: UIState.timerHubModule
            onClicked: UIState.timerHubModule = activeButton
        }

        Loader {
            height: 100; width: root.width

            sourceComponent: {
                switch(UIState.timerHubModule) {
                    case "timer": return tTimer;
                    case "stopWatch": return tStopWatch;
                    case "alarmСlock": return tAlarmClock;
                }
            }
        }
    }

    Component {
        id: tTimer

        Item {
            anchors.fill: parent

            TextStyled {
                text: "Таймер"
            }
        }
    }

    Component {
        id: tStopWatch

        Column {
            anchors.fill: parent

            TextStyledB {
                text: STime.stopWatchTime
            }

            Row {
                height: parent.height

                ButtonStyled {
                    // visible: !STime.isStopWatchRunning
                    height: parent.height / 3
                    text: !STime.isStopWatchRunning
                        ? STime.stopWatchCount > 0 ? "Продовжити" : "Запустити"
                        : "Стоп"
                    onClicked: !STime.isStopWatchRunning
                        ? STime.startStopWatch()
                        : STime.stopStopWatch()
                }

                ButtonStyled {
                    visible: STime.isStopWatchRunning || STime.stopWatchCount > 0
                    height: parent.height / 3
                    text: "Скинути"
                    onClicked: STime.restartStopWatch()
                }
            }
        }
    }

    Component {
        id: tAlarmClock

        Item {
            anchors.fill: parent

            TextStyled {
                text: "Будильник"
            }
        }
    }
}