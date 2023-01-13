import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15


Column {
    property alias textItem: inputId
    property string title: ""
    property bool fullWidth: true

    Label {
        text: parent.title
        font.pixelSize: 16
        color: "#90F2F2"
    }

    TextField {
        id: inputId
        implicitWidth: parent.fullWidth ? infoCol.width - 20 : infoCol.width * 0.7
        topPadding: 10
        bottomPadding: 10
        color: "#fff"
        font.pixelSize: 16
        background: Rectangle {
            color: "transparent"
            border.color: "#95A5A6"
            border.width: 2
            radius: 8
        }
    }
}
