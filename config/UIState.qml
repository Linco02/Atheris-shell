pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property QtObject bar: QtObject {
        property bool isHorizontal: (Settings.barPosition === "top" || Settings.barPosition === "bottom") 
    }

    property QtObject session: QtObject {
        property bool isLock: false
    }

    property QtObject power: QtObject {
        property bool isOpen: false
    }

    property QtObject authenficator: QtObject {
        property bool isOpen: false
    }

    property QtObject cheatsheet: QtObject {
        property bool isOpen: false
    }

    property QtObject atherisBase: QtObject {
        property bool isOpen: false
    }

    property QtObject atherisTranslate: QtObject {
        property bool isOpen: false
    }

    property QtObject background: QtObject {
        property bool isLoad: false

        property QtObject wallpaper: QtObject {
            property bool isLoad: false
        }

        property QtObject widgets: QtObject {
            property bool isLoad: false
        }
    }

    property QtObject atherisSettings: QtObject {
        property bool isOpen: false

        readonly property var modules: ["general", "display", "theme", "bluetooth", "network"]
        property string modul: "general"
    }

    property QtObject controlCenter: QtObject {
        property bool isOpen: false
        
        readonly property var modules: ["main", "sound", "wifi", "powerMode", "bluetooth"]
        property string modul: "main"

        property QtObject time: QtObject {
            readonly property var modules: ["timer", "stopWatch", "alarmСlock"]
            property string modul: "stopWatch"
        }
    }

    property QtObject atherisCenter: QtObject {
        property bool isOpen: false

        readonly property var modules: ["dashboard", "wallpaper", "command"]
        property string modul: "dashboard"

        property QtObject dashboard: QtObject {
            readonly property var modules: ["dash", "music", "performance"]
            property string modul: "dash"
        }
    }
}