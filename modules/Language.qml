import QtQuick
import Quickshell.Hyprland
import qs.components
import qs.settings

Item {
    height: 20; width: languageText.width + Style.padding * 2

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

    TextStyle2 {
        id: languageText
        anchors.centerIn: parent
        text: currentLayout
        font.weight: 600
    }
}

