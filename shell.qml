import QtQuick
import Quickshell
import qs.core
import qs.config
import qs.modules.bar
import qs.modules.power
import qs.modules.session
import qs.modules.background
import qs.modules.cheatsheet
import qs.modules.authenficator
import qs.modules.atheriscenter
import qs.modules.controllcenter
import qs.modules.translation
import qs.applications.atherissettings
import qs.applications.atherisbase

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens
        delegate: LazyLoader {
            required property var modelData
            active: Settings.isBarOn
            component: Bar {
                id: bar
                screen: modelData

                Loader {
                    sourceComponent: AtherisCenter {panel: bar}
                }
                Loader {
                    sourceComponent: ControlCenter {panel: bar}
                }
                Loader {
                    // active: UIState.power.isOpen
                    sourceComponent: Power {panel: bar}
                }
                Loader {
                    // active: UIState.power.isOpen
                    sourceComponent: Authenficator {panel: bar}
                }

                Loader {
                    // active: UIState.cheatsheet.isOpen
                    sourceComponent: CheatSheet {panel: bar}
                }
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
        active: UIState.session.isLock
        component: Lock {}
    }
    


    Loader {
        active: UIState.atherisSettings.isOpen
        sourceComponent: AtherisSettings {}
    }

    Loader {
        active: UIState.atherisBase.isOpen
        sourceComponent: AtherisBase {}
    }

    Loader {
        active: UIState.atherisTranslate.isOpen
        sourceComponent: Translation {}
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