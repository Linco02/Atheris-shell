pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pam

Singleton {
    id: root
    
    signal completed()
    signal error()

    function authenticate(password) {
        if (password === "") return
        
        if (pam.responseRequired)
            pam.respond(password)
    }
    function start() { pam.start() }
    function abort() { pam.abort () }

    PamContext {
        id: pam
        configDirectory: "/etc/pam.d"
        config: "quickshell"

        onCompleted: result => {
            if (result === PamResult.Success) root.completed()
            else {
                root.error()
                start()
            }
        }
    }
}