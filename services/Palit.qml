import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Item {
    readonly property var jsonData: JSON.parse(jsonFile.text())
    property var test: [] 

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