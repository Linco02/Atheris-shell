pragma Singleton
import QtQuick

QtObject {
    // ================
    // ==== Панелі ====
    // ================
    property bool enableTopPanel: true
    property bool enableBottomPanel: true
    property bool enableLeftPanel: true
    property bool enableRightPanel: true

    property var topPanel: [{
        leftSide: [ ],
        centerSide: [ ],
        rightSide: [ ]
    }]
    property var bottomPanel: [{
        leftSide: [ ],
        centerSide: [ ],
        rightSide: [ ]
    }]
    property var leftPanel: [{
        topSide: [ ],
        centerSide: [ ],
        bottomSide: [ ]
    }]
    property var rightPanel: [{
        topSide: [ ],
        centerSide: [ ],
        bottomSide: [ ]
    }]
}