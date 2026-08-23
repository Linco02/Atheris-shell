pragma Singleton
import Quickshell

Singleton {
    // PowerMode
    property var powerProfilesIcon: [
        {label: "PowerSaver", icon: "󰌪"},
        {label: "Balanced", icon: ""},
        {label: "Performance", icon: "󰊗"}
    ]
    
    // CommandCenter
    property var commandCenterModules: [
        {label: "wallpaper", icon: ""},
        {label: "dashboard", icon: "󰨝"},
        {label: "command", icon: ""},
    ]

    // AtherisCenter
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