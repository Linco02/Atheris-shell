import QtQuick
import Quickshell
import qs.config
import qs.modules.background
import qs.modules.bar


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

    // LazyLoader {
    //     active: Settings.enableNotificationsDaemon
    //     component: NotificationsDaemon {}
    // }
}