import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string title: title
    property int colWidth: colWidth

    Layout.fillWidth: true
    Layout.preferredWidth: colWidth
    height: 85
    color: "transparent"

    Text {
        text: parent.title
        font.pixelSize: 18
        color: "#fff"
        wrapMode: Text.Wrap
        anchors.verticalCenter: parent.verticalCenter
    }
}
