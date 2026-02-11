import QtQuick
import qs.components
import Quickshell.Hyprland

RectForeground {
    height: 20; width: 40

    property string currentLayout: "US"

    Text {
        anchors.centerIn: parent
        text: currentLayout
    }

    function currentLayoutParse(event) {
        if (event.name === "activelayout") {
            const dataString = event.data;
            const layoutInfo = dataString.split(",");
            const fullLayoutName = layoutInfo[layoutInfo.length - 1];
            if (fullLayoutName === "Ukrainian") {
                currentLayout =  "UA"
            } else {
                currentLayout =  "US"
            }
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect(currentLayoutParse);
    }
}

