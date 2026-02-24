import QtQuick
import Quickshell.Hyprland
import qs.services
import qs.config
import qs.components

Item {
    height: root.height - Appearance.padding.normal; width: languageText.width + Appearance.padding.normal

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

    TextStyledH {
        id: languageText
        anchors.centerIn: parent
        text: currentLayout
    }
}

