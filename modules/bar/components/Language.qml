import QtQuick
import qs.components
import qs.components.shapes
import qs.components.controls
import qs.config
import qs.services

RectForeground {
    height: parent.height; width: languageText.width + Global.padding.normal

    readonly property string currentLayoutName: LanguageServices.currentLayoutName

    TextStyledH {
        id: languageText
        anchors.centerIn: parent
        text: currentLayoutName
    }
}