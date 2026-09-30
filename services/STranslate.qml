pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string text: ""
    
    Process {
        command: [
            "sh", "-c",
            "area=$(slurp) || exit 1; " +
            "grim -g \"$area\" /tmp/ocr.png && " +
            "tesseract /tmp/ocr.png stdout -l eng+ukr 2>/dev/null | trans -b :uk"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.text = this.text.trim();
                console.log(root.text);
            }
        }

        
    }
}