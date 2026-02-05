pragma Singleton
import QtQuick
import qs.widgets

QtObject {
    property Component clockComp: Clock {}
    // ================
    // ==== Панелі ====
    // ================
    property bool enableTopPanel: false
    property bool enableBottomPanel: true
    property bool enableLeftPanel: false
    property bool enableRightPanel: false

    property var topPanel: {
        topORleftSide: [ ]
        centerSide: [ clockComp ]
        bottomORrightmSide: [ ]
    }
    property var bottomPanel: {
        topORleftSide: [ ]
        centerSide: [ clockComp ]
        bottomORrightmSide: [ ]
    }
    property var leftPanel: {
        topORleftSide: [ ]
        centerSide: [ clockComp ]
        bottomORrightmSide: [ ]
    }
    property var rightPanel: {
        topORleftSide: [ ]
        centerSide: [ clockComp ]
        bottomORrightmSide: [ ]
    }
}