import Quickshell.Widgets
import qs.config
import qs.services

IconImage {
    property string icon: ""

    implicitSize: parent.height - Global.padding.mini + 2
    source: AppIcons.getIcon(icon)
}