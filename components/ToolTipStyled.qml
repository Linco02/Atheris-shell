import QtQuick
import QtQuick.Controls
import qs.components.shapes

ToolTip {
    id: root
    delay: 300

    background: RectForeground { }
    contentItem: TextStyled { text: root.text }
}