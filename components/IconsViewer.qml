import Quickshell.Widgets
import qs.config
import qs.services

IconImage {
    property string icon: ""

    implicitSize: parent.height
    source: SIcon.getIcon(icon)
}