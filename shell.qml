import QtQuick
import Quickshell
import qs.config
import qs.services
import qs.modules.background
import qs.modules.bar
import qs.modules.bottomcenter
import qs.modules.lock

ShellRoot {
    // Задній фон //
    LazyLoader {
        active: Settings.enableBackground
        component: Background {}
    }

    LazyLoader {
        active: Settings.enableBar
        component: Bar {}
    }

    LazyLoader {
        active: Settings.enableBottomCenter
        component: BottomCenter {}
    }

    // LazyLoader {
    //     active: Settings.controlCenter
    //     component: ControlCenter {}
    // }

    // cлужби
    Palit { }
    Lock { }
}