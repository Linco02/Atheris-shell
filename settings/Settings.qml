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
        "topORleftSide": [ "../widgets/PowerButton.qml" , "../widgets/Workspace.qml", "../widgets/Programs.qml" ],
        "centerSide": [ "../widgets/Clock.qml" ],
        "bottomORrightSide": [ "../widgets/Services.qml" ]
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