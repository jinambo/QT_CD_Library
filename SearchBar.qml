import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

Rectangle {
    id: searchRect
    width: myWindow.width - 80
    height: 54
    //anchors.horizontalCenter: parent.horizontalCenter
    anchors.leftMargin: 40
    anchors.rightMargin: 40
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: 60
    color: "transparent"

    RowLayout {
        TextField {
            id: searchIn
            implicitWidth: searchRect.width * 0.75
            implicitHeight: searchRect.height
            placeholderText: "Type keywords to search ..."
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
            // onClicked: vyhledej
        }
    }
}
