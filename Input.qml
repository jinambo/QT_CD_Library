import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15


Column {
    property alias textItem: inputId
    property string title: ""
    property bool canEdit: true
    property bool fullWidth: true

    Label {
        text: parent.title
        font.pixelSize: 16
        color: "#90F2F2"
    }

    TextField {
        id: inputId
        enabled: parent.canEdit
        implicitWidth: parent.fullWidth ? infoCol.width - 20 : infoCol.width * 0.7 - 20
        topPadding: 10
        bottomPadding: 10
        color: "#fff"
        font.pixelSize: 16
        opacity: parent.canEdit ? 0.75 : 0.1
        background: Rectangle {
            color: "transparent"
            border.color: "#95A5A6"
            border.width: 2
            radius: 8
        }
    }
}
