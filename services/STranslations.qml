pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property var languages: ["en", "uk"]
    property string currentLanguage: "uk"
    property var dict: ({})

    function tr(key) {
        const value = dict[key]
        if (value === undefined) {
            // console.warn("Translations: missing key:", key)
            return key
        }
        return value
    }

    function setLanguage(language) {
        if (languages.includes(language)) {
            currentLanguage = language
        }
    }

    FileView {
        id: i18n
        path: Qt.resolvedUrl("../i18n/" + currentLanguage + ".js")
        watchChanges: true

        onLoaded: {
            try {
                const content = text()
                root.dict = (new Function("return " + content))()
            } catch (e) {
                console.warn("Translations: failed to parse", path, e)
            }
        }

        onLoadFailed: (error) => {
            console.warn("Translations: failed to load", path, error)
        }
    }
}