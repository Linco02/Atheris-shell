pragma Singleton
import Quickshell

Singleton {
    property var substitutions: ({
        "com.github.th_ch.youtube_music": "youtube-music",
        "codium": "vscodium",
        "mozilla firefox": "firefox"
    })

    property var networlIconMap: ({
        "wifi-excellent": "network-wireless-signal-excellent-symbolic",
        "wifi-good":      "network-wireless-signal-good-symbolic",
        "wifi-ok":        "network-wireless-signal-ok-symbolic",
        "wifi-weak":      "network-wireless-signal-weak-symbolic",
        "wifi-none":      "network-wireless-signal-none-symbolic",
        "ethernet":       "network-wired-symbolic",
        // "vpn":            "network-vpn-symbolic",
        "no-internet":    "network-wired-no-route-symbolic",
        "offline":        "network-offline-symbolic"
    })

    function mapIcon(icon, service) {
        if (!icon || !service) return Quickshell.iconPath("image-missing");

        const mapedIcon = "";

        if (service === "network") {
            mapedIcon = icon.find(i => i);
        }

        return Quickshell.iconPath(mapedIcon);
    }

    function getIcon(appId) {
        if (!appId) return Quickshell.iconPath("image-missing");

        // 1. Перевірка підміни (substitutions)
        let lowerId = appId.toLowerCase();
        if (substitutions[lowerId]) {
            return Quickshell.iconPath(substitutions[lowerId], true);
        }

        // 2. Пошук через DesktopEntries
        const entry = DesktopEntries.byId(appId) || DesktopEntries.heuristicLookup(appId);
        if (entry && entry.icon) {
            let path = Quickshell.iconPath(entry.icon, true);
            if (path && path.length > 0) return path;
        }

        // 3. Спроба використати appId як назву іконки (fallback)
        let directPath = Quickshell.iconPath(appId, true);
        if (directPath && directPath.length > 0) return directPath;

        console.log("services/Appicons відсутня іконка", appId)
        return Quickshell.iconPath("image-missing");
    }
}