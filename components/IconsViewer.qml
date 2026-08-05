import Quickshell.Widgets
import qs.config
import qs.services

IconImage {
    property string icon: ""

    implicitSize: parent.height - Style.padding.mini + 2
    source: SAppIcons.getIcon(icon)
}