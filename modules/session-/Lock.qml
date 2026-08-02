import QtQuick
import Quickshell.Wayland
import qs.config
import qs.services
import "./components"

WlSessionLock {
    locked: Global.isSessionLock

    onLockedChanged: {
        if (locked) PamServices.start()
        else PamServices.abort()
    }

    WlSessionLockSurface {
        id: lockSurface
        color: Colors.surface

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