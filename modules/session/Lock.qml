import QtQuick
import Quickshell.Wayland
import qs.config
import qs.services
import "./components"

WlSessionLock {
    locked: UIState.isSessionLock

    onLockedChanged: {
        if (locked) PamServices.start()
        else PamServices.abort()
    }

    WlSessionLockSurface {
        id: lockSurface
        color: Theme.surface

        Background { }

        Column {
            anchors.centerIn: parent
            spacing: 40

            Today { }
            Enter { }
            Power { }
        }

        CreatorInfo {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
        }
    }
}