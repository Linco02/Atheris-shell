import QtQuick
import QtQuick.Layouts
import qs.components.containers
import qs.config
import "./components"

Item {
    height: container.height; width: container.width

    property int brick: 100

    function b(span) {
        return brick * span + (span - 1) * spacing
    }

    RowStyled {
        anchors.horizontalCenter: parent.horizontalCenter
        id: container

        ColumnStyled {
            RowStyled {
                ClockDate {
                    height: b(1) || brick; width: b(2)
                }

                Weather {
                    height: b(1) || brick; width: b(2)
                }
            }

            RowStyled {
                Calendar {
                    height: b(3) || brick; width: b(3)
                }

                PerfomanceDash {
                    height: b(3) || brick; width: b(1)
                }
            }
        }

        MusicDash {
            height: b(4) || brick; width: b(3)
        }
    }
}