import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.modules.background
import qs.modules.bar
// import qs.modules.bottomcenter
import qs.modules.lock

ShellRoot {
    LazyLoader {
        active: GlobalStates.isBackgroundOn
        component: Background {}
    }

    LazyLoader {
        active: GlobalStates.isBarOn
        component: Bar {}
    }

    LazyLoader {
        active: GlobalStates.isShortcutOn
        component: Shortcuts { }
    }

    Lock { }
}