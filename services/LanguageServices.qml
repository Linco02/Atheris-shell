pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    property string currentLayoutName: "US"

    function currentLayoutParse(event) {
        if (event.name === "activelayout") {
            const dataString = event.data;
            const layoutInfo = dataString.split(",");
            const fullLayoutName = layoutInfo[layoutInfo.length - 1];
            if (fullLayoutName === "Ukrainian") {
                currentLayoutName =  "UA"
            } else {
                currentLayoutName =  "US"
            }
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect(currentLayoutParse);
    }
}