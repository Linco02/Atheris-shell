pragma Singleton
import Quickshell

Singleton {
    // PowerMode
    property var powerModes: [
        {label: "power-saver", icon: "󰌪"},
        {label: "balanced", icon: ""},
        {label: "performance", icon: "󰊗"}
    ]
    
    // CommandCenter
    property var commandCenterModules: [
        {label: "wallpaper", icon: ""},
        {label: "dashboard", icon: "󰨝"},
        {label: "command", icon: ""},
    ]
}