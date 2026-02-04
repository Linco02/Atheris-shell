import QtQuick

MouseArea {
    signal open()
    signal exit()

    hoverEnabled: true
    onEntered: { open() }
    onExited: { exit() }
}
