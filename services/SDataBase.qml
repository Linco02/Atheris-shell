pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.LocalStorage

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
            tx.executeSql(`CREATE TABLE IF NOT EXISTS settings (${columnsSql})`);
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

    Process {
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

    // function setValue(key, value) {
    //     try {
    //         var db = getDb();
    //         db.transaction(function(tx) {
    //             tx.executeSql('INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)', [key, value]);
    //         });
    //     } catch (err) {
    //         console.error("SDataBase error in setValue:", err);
    //     }
    // }

    // function getValue(key, callback) {
    //     try {
    //         var freeDb = getDb();
    //         freeDb.readTransaction(function(tx) {
    //             var rs = tx.executeSql('SELECT value FROM settings WHERE key = ?', [key]);
    //             if (rs.rows.length > 0) {
    //                 callback(rs.rows.item(0).value);
    //             } else {
    //                 callback(null);
    //             }
    //         });
    //     } catch (err) {
    //         console.error("SDataBase error in getValue:", err);
    //         callback(null);
    //     }
    // }

    property var baseDataTest: [["name", "Text"], ["url", "Text"], ["page", "Text"]]
    property var baseDataTestValue: [["name", "Didi"], ["url", "git.com"], ["page", "122"]]

    Component.onCompleted: {
        // console.log(LocalStorage.openDatabaseSync())
        // setValue("BaseTest1", baseDataTestValue)
        // createValue("BaseTest1", [
        //     ["name", "Pith"],
        //     ["url", "https://pith.com"],
        //     ["page", "23"]
        // ]);
        // createDb("BaseTest1", baseDataTest)

        // getValues("BaseTest1", "name")

        // getDb("Bases")
        // setValue("theme", "dark");
        // getValue("theme", function(val) {
        //     console.log("Збережена тема:", val);
        // });
    }
}