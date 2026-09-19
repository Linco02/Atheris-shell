import QtQuick
import qs.config

Grid {
    columns: isHorizontal ? count : 1
    rows: isHorizontal ? 1 : count
    spacing: Theme.spacing.normal

    property int count: 0
    property bool isHorizontal: true
}