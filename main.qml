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
    title: qsTr("Hello World")

    Library {
        id: library
    }

    SearchBar { }

    Button {
        id: myBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        text: "Quick test"
        onClicked: {
            const tracks = ["Test 1", "Test 2"]
            library.addAlbum("assets/booklets/snake_monastery.png", "Hangjaw", "Hydra", "2022", "Neurofunk DNB", tracks)
        }
    }

    Rectangle {
        id: dataWrapper
        implicitWidth: myWindow.width - 80
        implicitHeight: parent.height - 250
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
            implicitWidth: dataWrapper.width
            implicitHeight: dataWrapper.height

            Text {
                text: "Your favorite music"
                color: "#90F2F2"
                font.pixelSize: 32
                bottomPadding: 40
            }

            RowLayout {
                id: dataTitles
                width: dataWrapper.width
                anchors.topMargin: 40

                Rectangle { width: 5; height: 20; color: "transparent" }

                Rectangle {
                    width: dataWrapper.width * 0.1
                    height: 85
                    color: "transparent"

                    Text {
                        text: "Picture"
                        font.pixelSize: 18
                        color: "#90F2F2"
                    }
                }

                Rectangle {
                    width: dataWrapper.width * 0.25
                    height: 85
                    color: "transparent"

                    Text {
                        text: "Title"
                        font.pixelSize: 18
                        color: "#90F2F2"
                    }
                }

                Rectangle {
                    width: dataWrapper.width * 0.2
                    height: 85
                    color: "transparent"

                    Text {
                        text: "Author"
                        font.pixelSize: 18
                        color: "#90F2F2"
                    }
                }

                Rectangle {
                    width: dataWrapper.width * 0.1
                    height: 85
                    color: "transparent"

                    Text {
                        text: "Date"
                        font.pixelSize: 18
                        color: "#90F2F2"
                    }
                }

                Rectangle {
                    width: dataWrapper.width * 0.25
                    height: 85
                    color: "transparent"

                    Text {
                        text: "Genre"
                        font.pixelSize: 18
                        color: "#90F2F2"
                    }
                }

                Rectangle {
                    width: dataWrapper.width * 0.1
                    height: 85
                    color: "transparent"
                }
            }

            Rectangle {
                width: dataWrapper.implicitWidth
                Layout.fillHeight: true
                anchors.top: dataTitles.top
                anchors.topMargin: 30
                color: "transparent"

                LibraryView {}
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
            onClicked: createPopup.open()
            cursorShape: Qt.PointingHandCursor
        }
    }
}
