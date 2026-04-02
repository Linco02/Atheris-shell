pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    property AppearanceConfig appearance: AppearanceConfig {
        path: Quickshell.configDir + "/appearance.json"
    }
    property ColorsConfig colors: ColorsConfig {
        path: Quickshell.configDir + "/colors.json"
    }
    property SettingsConfig settings: SettingsConfig {
        path: Quickshell.configDir + "/settings.json"
    }
}