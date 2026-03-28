pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.services

Singleton {
    readonly property var jsonData: JSON.parse(jsonFile.text())
    property var test: []

    function palitCreate(path) {
        paliCreator.command = [
            "matugen",
            "image",
            "--source-color-index", "0",
            Wallpapers.wallpaperRawPath(path)
        ]
        paliCreator.running = GlobalStates.isPalitOn
        openrgbUpdate.running = GlobalStates.isOpenrgbOn
        pywalfoxUpdate.running = GlobalStates.isPywalFoxOn
    }

    Process {
        id: paliCreator
    }

    Process {
        id: openrgbUpdate
        command: [
            "sh", "/tmp/atheris/openrgb.sh"
        ]
    }

    Process {
        id: pywalfoxUpdate
        command: [
            "sh", "/tmp/atheris/pywalfox.sh"
        ]
    }

    function applyPalette(data) {
        if (!data) return;

        Colors.surface       = data.surface       || Colors.surface;
        Colors.surfaceRaised = data.surfaceRaised || Colors.surfaceRaised;
        Colors.outline       = data.outline       || Colors.outline;
        Colors.active        = data.active        || Colors.active;
        Colors.inactive      = data.inactive      || Colors.inactive;
        Colors.warning       = data.warning       || Colors.warning;

        Colors.textSurface   = data.textSurface   || Colors.textSurface;
        Colors.textAccent    = data.textAccent    || Colors.textAccent;
        Colors.textInactive  = data.textInactive  || Colors.textInactive;
    }

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl("/tmp/atheris/palette.json")
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }

    onJsonDataChanged: {
        if (jsonData) {
            applyPalette(jsonData);
        }
    }
}