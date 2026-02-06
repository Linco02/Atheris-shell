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
    property bool enableBottomPanel: true
    property bool enableLeftPanel: true
    property bool enableRightPanel: true

    // property var topPanel: {
    //     topORleftSide: [ ]
    //     centerSide: [ Clock ]
    //     bottomORrightmSide: [ ]
    // }
    // property var bottomPanel: {
    //     topORleftSide: [ ]
    //     centerSide: [ Clock ]
    //     bottomORrightmSide: [ ]
    // }
    // property var leftPanel: {
    //     topORleftSide: [ ]
    //     centerSide: [ Clock ]
    //     bottomORrightmSide: [ ]
    // }
    // property var rightPanel: {
    //     topORleftSide: [ ]
    //     centerSide: [ Clock ]
    //     bottomORrightmSide: [ ]
    // }
}