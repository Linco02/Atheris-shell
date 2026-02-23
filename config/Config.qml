pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property AppearanceConfig appearance: AppearanceConfig {}
    property AppearanceConfig padding: AppearanceConfig {}
    // коли захочеш JSON — просто додаси:
    // path: Quickshell.configDir + "/appearance.json"
}