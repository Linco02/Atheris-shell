pragma Singleton
import Quickshell

Singleton {
    property var substitutions: ({
        "com.github.th_ch.youtube_music": "youtube-music",
        "codium": "vscodium",
        "mozilla firefox": "firefox"
    })

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