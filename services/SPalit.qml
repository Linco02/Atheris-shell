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
        if (Settings.isAdaptivePalitOn) {
            paliCreator.command = [
                "matugen",
                "image",
                "--mode", Settings.palitMode,
                "--source-color-index", colorIndex,
                path
            ]
            paliCreator.running = true
            curentPath = path
        }
    }

    function applyPalette(data) {
        if (!data) return;

        Theme.colors.surface = Qt.alpha(data.surface, Style.opacity) || Theme.colors.surface;
        Theme.colors.surfaceRaised = data.surfaceRaised || Theme.colors.surfaceRaised;
        Theme.colors.outline = data.outline || Theme.colors.outline;
        Theme.colors.active = data.active || Theme.colors.active;
        Theme.colors.inactive = data.inactive || Theme.colors.inactive;
        Theme.colors.warning = data.warning || Theme.colors.warning;

        Theme.colors.textSurface = data.textSurface || Theme.colors.textSurface;
        Theme.colors.textAccent = data.textAccent || Theme.colors.textAccent;
        Theme.colors.textInactive = data.textInactive || Theme.colors.textInactive;
        
        console.log(
            data.surface,
            data.surfaceRaised,
            data.outline,
            data.active,
            data.inactive,
            data.warning,
            data.textSurface,
            data.textAccent,
            data.textInactive
        )
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
        target: Settings
        function onPalitModeChanged() {
            if (curentPath !== "") palitCreate(curentPath)
        }
    }
}