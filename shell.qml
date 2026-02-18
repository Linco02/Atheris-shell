import QtQuick
import Quickshell
import qs.panels
import qs.settings

ShellRoot {

    LazyLoader {
        active: Settings.enableBackground
        component: Background {}
    }

    // LazyLoader {
    //     active: Settings.enableNotificationsDaemon
    //     component: NotificationsDaemon {}
    // }

    LazyLoader {
        active: Settings.enableTopPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Top }
    }
    LazyLoader {
        active: Settings.enableBottomPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Bottom }
    }
    LazyLoader {
        active: Settings.enableLeftPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Left }
    }
    LazyLoader {
        active: Settings.enableRightPanel
        component: Panel { property int ancorSide: Panel.PanelSide.Right }
    }
    
}