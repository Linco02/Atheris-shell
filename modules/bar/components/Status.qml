import QtQuick
import qs.components.shapes
import qs.components.containers
import qs.config
import "./status"

RectForeground {
    height: parent.height; width: statusContainer.width

    RowSpaced {
        id: statusContainer
        height: parent.height
        leftPadding: Global.padding.normal; rightPadding: Global.padding.normal

        Sound { }
        Battery { }
        Bluetooth { }
        Network { }
        Language { }
    }
}