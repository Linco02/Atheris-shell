import QtQuick
import qs.components
import Quickshell.Hyprland

RectForeground {
    height: 20; width: 100

    property string currentLayout: "us"

    Text {
        anchors.centerIn: parent
        text: currentLayout
    }

    function parseLayout(fullLayoutName) {
        if (!fullLayoutName) return;
        const shortName = fullLayoutName.substring(0, 20).toLowerCase();
        if (currentLayout !== shortName) {
            currentLayout = shortName;
        }
    }

    function handleRawEvent(event) {
        if (event.name === "activelayout") {
            const dataString = event.data;
            const layoutInfo = dataString.split(",");
            const fullLayoutName = layoutInfo[layoutInfo.length - 1];
            parseLayout(fullLayoutName);
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect(handleRawEvent);
    }
}

