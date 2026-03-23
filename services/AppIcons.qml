pragma Singleton
import Quickshell

Singleton {
    property var substitutions: ({
        "com.github.th_ch.youtube_music": "youtube-music",
    })

    function getIcon(appId) {
        let sub = (appId === substitutions[appId] || substitutions[appId.toLowerCase()] )
        if (sub) return Quickshell.iconPath(sub, true);

        const entry = DesktopEntries.byId(appId) || DesktopEntries.heuristicLookup(appId);
        if (entry && entry.icon) {
            let path = Quickshell.iconPath(entry.icon, true);
            if (path.length > 0) return path;
        }

        return Quickshell.iconPath("image-missing");
    }
}