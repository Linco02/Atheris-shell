pragma Singleton
import Quickshell
import Quickshell.Wayland

Singleton {
    property var topLevels: ToplevelManager.toplevels.values
    property int amountTopLevels: topLevels.length
}