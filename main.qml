import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import LibraryLib 1.0


Window {
    id: myWindow
    width: 1280
    height: 832
    visible: true
    color: "#34495E"
    title: qsTr("CD Library")

    Library {
        id: library
    }

    SearchBar { }


    Rectangle {
        id: dataWrapper
        width: myWindow.width - 80
        height: parent.height - 250
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 40
        anchors.topMargin: 200
        anchors.rightMargin: 40
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent

            Text {
                text: library.filter ? `Results for: ${library.filter}` : "Search your favorite music"
                color: "#90F2F2"
                font.pixelSize: 32
                bottomPadding: 40
            }

            RowLayout {
                id: dataTitles
                width: dataWrapper.width
                anchors.topMargin: 40

                Rectangle { width: 5; height: 20; color: "transparent" }

                ColumnTitle { colWidth: 1; title: "Picture" }
                ColumnTitle { colWidth: 2; title: "Title" }
                ColumnTitle { colWidth: 2; title: "Author" }
                ColumnTitle { colWidth: 1; title: "Year" }
                ColumnTitle { colWidth: 2; title: "Genre" }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    height: 20
                    color: "transparent"
                }
            }

            Rectangle {
                width: dataWrapper.width
                Layout.fillHeight: true
                //anchors.top: dataTitles.top
                //anchors.topMargin: 30
                color: "transparent"

                LibraryView {
                    width: dataWrapper.width
                    height: parent.height
                }
            }
        }
    }

    CreatePopup {
        id: createPopup
    }

    Image {
        width: 30
        height: 30
        source: "assets/add.svg"
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        MouseArea {
            width: parent.width
            height: parent.height
            onClicked: createPopup.create()
            cursorShape: Qt.PointingHandCursor
        }
    }
}
