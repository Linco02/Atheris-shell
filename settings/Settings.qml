pragma Singleton
import QtQuick
import qs.widgets

QtObject {
    property bool enableBackground: true
    property bool enableWallpaper: true
    // ================
    // ==== Панелі ====
    // ================
    property bool enableTopPanel: true
    property bool enableBottomPanel: false
    property bool enableLeftPanel: false
    property bool enableRightPanel: false

    property var topPanel: {
        "topORleftSide": [ "../widgets/Workspace.qml", "../widgets/Programs.qml" ],
        "centerSide": [ "../widgets/Clock.qml" ],
        "bottomORrightSide": [ "../widgets/Volume.qml", "../widgets/Network.qml", "../widgets/Language.qml" ]
    }
    property var bottomPanel: {
        "topORleftSide": [  ],
        "centerSide": [  ],
        "bottomORrightSide": [  ]
    }
    property var leftPanel: {
        "topORleftSide": [  ],
        "centerSide": [  ],
        "bottomORrightSide": [  ]
    }
    property var rightPanel: {
        "topORleftSide": [  ],
        "centerSide": [  ],
        "bottomORrightSide": [  ]
    }
}