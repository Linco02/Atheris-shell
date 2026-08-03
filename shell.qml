import QtQuick
import Quickshell
import qs.core
import qs.config
import qs.modules.bar
// import qs.modules.session
import qs.modules.background
// import qs.modules.atherissettings

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: LazyLoader {
            required property var modelData
            active: Settings.isBarOn
            component: Bar { screen: modelData }
        }
    }

    Variants {
        model: Quickshell.screens
        delegate: LazyLoader {
            required property var modelData
            active: Settings.isBackgroundOn
            component: Background { screen: modelData }
        }
    }

    // LazyLoader {
    //     active: Global.isSessionLock
    //     component: Lock { }
    // }

    // LazyLoader {
    //     active: Global.settings.isShortcutOn
    //     component: Shortcuts { }
    // }

    // Loader {
    //     active: Global.isAtherisSettingsOpen
    //     source: "./modules/atherissettings/AtherisSettings.qml"
    // }
}