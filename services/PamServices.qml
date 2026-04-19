pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pam

Singleton {
    id: root
    
    property string _password: ""
    
    signal completed()
    signal error()

    function authenticate(password) {
        _password = password
        pam.start()
    }

    PamContext {
        id: pam
        configDirectory: "/etc/pam.d"
        config: "quickshell"

        onPamMessage: {
            if (responseRequired) {
                respond(_password)
            }
        }

        onCompleted: result => {
            _password = ""

            if (result === PamResult.Success) root.completed()
            else root.error()
        }
    }
}