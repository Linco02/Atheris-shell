pragma Singleton
import Qt.labs.folderlistmodel
import QtQuick
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var listBase: []
    property bool d: false

    function getDb(name, version = "1.0") {
        return LocalStorage.openDatabaseSync(name, version);
    }

    function createDb(name, args) {
        const db = getDb(name);
        const columnsSql = args.map(pair => pair.join(" ")).join(", ");

        db.transaction(function(tx) {
            tx.executeSql(`CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY AUTOINCREMENT ${columnsSql})`);
        });
    }

    function createValues(name, value) {
        if (!name) return

        const colKey = value.map(c => c[0]).join(", ");
        const colvalue = value.map(c => c[1]);
        const col = value.map(() => "?").join(", ")

        const db = getDb(name)
        db.transaction(function(tx) {
            tx.executeSql(`INSERT INTO settings (${colKey}) VALUES (${col})`, colvalue);
        });
    }

    function getValues(name, key) {
        if(!name) return null

        const db = getDb(name)
        let result = []

        db.readTransaction(function(tx) {
            const rs = tx.executeSql(`SELECT ${key} FROM settings`);

            for (let i = 0; i < rs.rows.length; i++)
                result.push(rs.rows.item(i).name);
        });

        return result
    }

    function getAllValues(name) {
        if(!name) return null

        const db = getDb(name)
        let result = []

        db.readTransaction(function(tx) {
            const rs = tx.executeSql(`SELECT * FROM settings`);

            for (let i = 0; i < rs.rows.length; i++)
                result.push(rs.rows.item(i));
        });

        // for (var i = 0; i < result.length; i++) {
        //     console.log(`Рядок ${i}:`, JSON.stringify(result[i]));
        //     // Доступ до окремих полів об'єкта:
        //     // console.log("Name:", rows[i].name, "URL:", rows[i].url);
        // }

        return result
    }

    function fetchData(data) {
        const result = Object.keys(testData)
            .filter(d => d.startsWith("image"))

        console.log(testData[0].image0)
        return []
    }

    FolderListModel {
        folder: "file:///home/linco02/.local/share/quickshell/QML/OfflineStorage/Databases/"
        nameFilters: "*/.ini"

        function updateFiles() {
            dbUpdate.running = true
        }
    }

    Process {
        id: dbUpdate
        running: true
        command: [
            "sh", "-c",
            "grep -h '^Name=' ~/.local/share/quickshell/QML/OfflineStorage/Databases/*.ini 2>/dev/null | cut -d'=' -f2"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                listBase = this.text.trim().split("\n")
            }
        }
    }

    property var baseDataTest: [["name", "Text"], ["url", "Text"], ["page", "Text"]]
    property var baseDataTestValue: [["name", "Didi"], ["url", "git.com"], ["page", "122"]]
}