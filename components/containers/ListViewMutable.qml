import QtQuick

ListView {
    orientation: isHorizontal ? ListView.Horizontal : ListView.Vertical
    interactive: false

    property bool isHorizontal: true
}