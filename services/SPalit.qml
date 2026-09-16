pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.services

Singleton {
    readonly property var jsonData: JSON.parse(jsonFile.text())
    property string curentPath: ""
    property QtObject colors: QtObject {
        property color surface: "#fff"
        property color surfaceRaised: "#fff"
        property color outline: "#fff"
        property color active: "#fff"
        property color inactive: "#fff"
        property color warning: "#fff"

        property color textSurface: "#fff"
        property color textAccent: "#fff"
        property color textInactive: "#fff"
    }

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

        colors.surface = Qt.alpha(data.surface, Theme.opacity);
        colors.surfaceRaised = data.surfaceRaised;
        colors.outline = data.outline;
        colors.active = data.active;
        colors.inactive = data.inactive;
        colors.warning = data.warning;

        colors.textSurface = data.textSurface;
        colors.textAccent = data.textAccent;
        colors.textInactive = data.textInactive;
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