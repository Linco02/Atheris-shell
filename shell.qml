import QtQuick
import Quickshell
import qs.core
import qs.config
import qs.modules.bar
import qs.modules.session
import qs.modules.background
import qs.modules.atheriscenter
import qs.modules.controllcenter
import qs.modules.atherissettings

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: LazyLoader {
            required property var modelData
            active: Settings.isBarOn
            component: Bar {
                id: bar
                screen: modelData

                Loader {sourceComponent: AtherisCenter {panel: bar}}
                Loader {sourceComponent: ControlCenter {panel: bar}}
            }
        }
    }

    Variants {
        model: Quickshell.screens
        delegate: LazyLoader {
            required property var modelData
            active: Settings.isBackgroundOn
            component: Background {screen: modelData}
        }
    }

    Shortcut {}

    LazyLoader {
        active: UIState.isSessionLock
        component: Lock {}
    }

    Loader {
        active: UIState.isAtherisSettingsOpen
        sourceComponent: AtherisSettings {}
    }



//     Loader {
//         sourceComponent: Power { panel: root }
//     }

//     Loader {
//         sourceComponent: ControlCenter { panel: root }
//     }

    // Loader {
    //     active: Global.isAtherisSettingsOpen
    //     source: "./modules/atherissettings/AtherisSettings.qml"
    // }
}