import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

    RowLayout {
        width: parent.width

        TextField {
            id: authorIn
            Layout.fillWidth: true
            Layout.preferredWidth: 3
            implicitHeight: searchRect.height
            placeholderText: "Type author ..."
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

        TextField {
            id: genreIn
            Layout.fillWidth: true
            Layout.preferredWidth: 3
            implicitHeight: searchRect.height
            placeholderText: "Type genre ..."
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

        TextField {
            id: yearIn
            Layout.fillWidth: true
            Layout.preferredWidth: 2
            implicitHeight: searchRect.height
            placeholderText: "Type year ..."
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
            Layout.fillWidth: true
            Layout.preferredWidth: 2
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
                onClicked: library.setFilter(
                     "?" +
                     (authorIn.text ? "author:" + authorIn.text : "") +
                     (genreIn.text ? " genre:" + genreIn.text : "") +
                     (yearIn.text ? " year:" + yearIn.text : "")
                )
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

