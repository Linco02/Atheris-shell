import QtQuick
import qs.components
import qs.services

Item {
    height: parent.height; width: languageText.width

    readonly property string currentLayoutName: LanguageServices.currentLayoutName

    TextStyledH {
        id: languageText
        anchors.centerIn: parent
        text: currentLayoutName
    }
}