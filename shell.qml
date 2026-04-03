import Quickshell
import qs.config
import qs.modules.bar
import qs.modules.background

ShellRoot {
    LazyLoader {
        active: Global.settings.isBackgroundOn
        component: Background {}
    }

    LazyLoader {
        active: Global.settings.isBarOn
        component: Bar {}
    }
}