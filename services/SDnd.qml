pragma Singleton
import Quickshell
import qs.config

Singleton  {
    function dndToggle() {
        Settings.isDndOn = !Settings.isDndOn
    }
}