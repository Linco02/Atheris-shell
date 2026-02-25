import QtQuick
import Quickshell
import qs.config
import qs.modules.background
import qs.modules.bar
import qs.modules.bottomcenter


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
    //     active: Settings.enableNotificationsDaemon
    //     component: NotificationsDaemon {}
    // }
}