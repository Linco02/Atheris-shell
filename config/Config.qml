pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias appearance: adapter.appearance
    property alias settings: adapter.settings

    FileView {
        id: fileView
        path: Quickshell.shellDir + "/shell.json"
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter
            property AppearanceConfig appearance: AppearanceConfig {}
            property SettingsConfig settings: SettingsConfig {}
        }
    }
}