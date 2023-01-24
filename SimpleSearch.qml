import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

RowLayout {
    TextField {
        id: searchIn
        implicitWidth: searchRect.width * 0.75
        implicitHeight: searchRect.height
        placeholderText: "Type album title to search ..."
        placeholderTextColor: "#C3D3D4"
        color: "#fff"
        font.pixelSize: 20
        verticalAlignment: TextInput.AlignVCenter
        background: Rectangle {
            color: "transparent"
            border.color: "#95A5A6"
            border.width: 2
            radius: 8
        }
    }

    Button {
        id: searchBtn
        implicitWidth: searchRect.width * 0.25
        implicitHeight: searchRect.height
        text: "Search"
        font.pixelSize: 20

        background: Rectangle {
                color: parent.down ? "#6ED1D1" :
                        (parent.hovered ? "#6ED1D1" : "#90F2F2")
                radius: 8
        }

        MouseArea {
            width: parent.width
            height: parent.height
            onClicked: library.setFilter(searchIn.text)
            cursorShape: Qt.PointingHandCursor
        }
    }
}
