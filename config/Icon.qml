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
    property var atherisCenterModules: [
        {label: "wallpaper", icon: ""},
        {label: "dashboard", icon: "󰨝"},
        {label: "command", icon: ""},
    ]

    // Notification
    property var notificationsUrgents: [
        {label: "low", icon: "dialog-information"},
        {label: "normal", icon: "dialog-warning"},
        {label: "critical", icon: "dialog-error"}
    ]
}