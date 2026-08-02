pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.services

Singleton {
    readonly property var jsonData: JSON.parse(jsonFile.text())
    property string curentPath: ""

    function palitCreate(path) {
        const colorIndex = Settings.palitMode === "dark" ? 0 : 2
        if (Settings.isPalitOn) {
            paliCreator.command = [
                "matugen",
                "image",
                "--mode", Settings.palitMode,
                "--source-color-index", colorIndex,
                WallpaperService.wallpaperRawPath(path)
            ]
            paliCreator.running = true
            curentPath = path
        }
    }

    function applyPalette(data) {
        if (!data) return;

        Theme.surface       = data.surface       || Theme.surface;
        Theme.surfaceRaised = data.surfaceRaised || Theme.surfaceRaised;
        Theme.outline       = data.outline       || Theme.outline;
        Theme.active        = data.active        || Theme.active;
        Theme.inactive      = data.inactive      || Theme.inactive;
        Theme.warning       = data.warning       || Theme.warning;

        Theme.textSurface   = data.textSurface   || Theme.textSurface;
        Theme.textAccent    = data.textAccent    || Theme.textAccent;
        Theme.textInactive  = data.textInactive  || Theme.textInactive;
    }

    Process {
        id: paliCreator
        onExited: (exitCode) => {
            if (exitCode === 0) {
                if (Settings.palitOpenrgbOn) openrgbUpdate.running = true
                if (Settings.palitPywalFoxOn) pywalfoxUpdate.running = true
                if (Settings.palitKittyOn) kittyUpdate.running = true
                if (Settings.palitqt6ctOn) qt6ctUpdate.running = true
            }
        }
    }

    Process {
        id: openrgbUpdate
        command: [ "sh", "/tmp/atheris/openrgb.sh" ]
    }

    Process {
        id: pywalfoxUpdate
        command: [ "sh", "/tmp/atheris/pywalfox.sh" ]
    }

    Process {
        id: kittyUpdate
        command: [ "pkill", "-USR1", "kitty" ]
    }

    Process {
        id: qt6ctUpdate
        command: [
            "sh", "-c", "sed -i 's|^color_scheme_path=.*|color_scheme_path=/tmp/atheris/qt6ct.conf|' ~/.config/qt6ct/qt6ct.conf"
        ]
    }

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl("/tmp/atheris/palette.json")
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }

    onJsonDataChanged: {
        if (jsonData && Settings.palitShellOn) {
            applyPalette(jsonData);
        }
    }

    Connections {
        target: Global
        function onPalitModeChanged() {
            if (curentPath !== "") palitCreate(curentPath)
        }
    }
}