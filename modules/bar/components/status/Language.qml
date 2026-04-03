import QtQuick
import Quickshell.Hyprland
import qs.services
import qs.config
import qs.components

Item {
    height: parent.height; width: languageText.width

    property string currentLayout: "US"

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

    TextStyledFH {
        id: languageText
        anchors.centerIn: parent
        text: currentLayout
    }
}