pragma Singleton
import Quickshell

Singleton {
    function toName(path) {
        let parce = path.toString().split("/")
        return parce[parce.length - 1]
    }
}