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
            WallpaperService.wallpaperRawPath(path)
        ]
        paliCreator.running = Global.settings.isPalitOn
    }

    Process {
        id: paliCreator
        onExited: (exitCode) => {
            if (exitCode === 0) {
                if (Global.settings.palitOpenrgbOn) openrgbUpdate.running = true
                if (Global.settings.palitPywalFoxOn) pywalfoxUpdate.running = true
                if (Global.settings.palitKittyOn) kittyUpdate.running = true
                if (Global.settings.palitqt6ctOn) qt6ctUpdate.running = true
            }
        }
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

    Process {
        id: kittyUpdate
        command: [
            "pkill", "-USR1", "kitty"
        ]
    }

    Process {
        id: qt6ctUpdate
        command: [
            "sh", "sed -i 's|^color_scheme_path=.*|color_scheme_path=/tmp/atheris/qt6ct.conf|' ~/.config/qt6ct/qt6ct.conf"
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
        if (jsonData && Global.settings.palitShellOn) {
            applyPalette(jsonData);
        }
    }
}