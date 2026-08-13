import QtQuick
import qs.core
import qs.components
import qs.components.controls
import qs.components.containers

Item {
    height: parent.height; width: height

    RowStyled {
        ButtonStyled {
            height: 40; width: height
            text: ""
            onClicked: Update.updateShell()
        }

        TextStyled {
            text: "Оновлення"
        }
    }
}