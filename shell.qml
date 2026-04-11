import QtQuick
import Quickshell
import qs.config
import qs.modules.bar
import qs.modules.session
import qs.modules.background
import qs.modules.atherissettings

ShellRoot {
    LazyLoader {
        active: Global.settings.isBackgroundOn
        component: Background { }
    }

    LazyLoader {
        active: Global.isSessionLock
        component: Lock { }
    }

    LazyLoader {
        active: Global.settings.isBarOn
        component: Bar { }
    }

    LazyLoader {
        active: Global.settings.isShortcutOn
        component: Shortcuts { }
    }

    // Loader {
    //     active: Global.isAtherisSettingsOpen
    //     sourceComponent: "AtherisSettings"
    // }

    // AtherisSettings {}
}