import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string title: title
    property int colWidth: colWidth

    Layout.fillWidth: true
    Layout.preferredWidth: colWidth
    height: 20
    color: "transparent"

    Text {
        text: parent.title
        font.pixelSize: 18
        font.weight: 600
        color: "#90F2F2"
        opacity: 0.7
    }
}
