import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ListView {
    id: theView
    implicitWidth: parent.width
    implicitHeight: parent.height
    clip: true
    model: library.albums
    spacing: 10

    delegate: Rectangle {
        width: parent.width
        height: childrenRect.height
        color: "#253546"
        radius: 8

        ColumnLayout {

            RowLayout {
                width: parent.width
                Rectangle { width: 5; height: 20; color: "transparent" }

                Rectangle {
                    width: theView.width * 0.1
                    height: 85
                    color: "transparent"

                    Image {
                        width: 65
                        height: 65
                        source: modelData.imgUrl
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter

                    }
                }

                Rectangle {
                    id: rectLayout
                    width: theView.width * 0.25
                    height: 85
                    color: "transparent"

                    Text {
                        text: modelData.title
                        font.pixelSize: 18
                        color: "#fff"
                        width: theView.width * 0.25
                        wrapMode: Text.Wrap
                        anchors.verticalCenter: parent.verticalCenter
                        // leftPadding: 20
                    }
                }

                Rectangle {
                    width: theView.width * 0.2
                    height: 85
                    color: "transparent"

                    Text {
                        text: modelData.author
                        font.pixelSize: 18
                        color: "#fff"
                        width: theView.width * 0.2
                        wrapMode: Text.Wrap
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    width: theView.width * 0.1
                    height: 85
                    color: "transparent"

                    Text {
                        text: modelData.date
                        font.pixelSize: 18
                        color: "#fff"
                        width: theView.width * 0.1
                        wrapMode: Text.Wrap
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    width: theView.width * 0.25
                    height: 85
                    color: "transparent"

                    Text {
                        text: modelData.genre
                        font.pixelSize: 18
                        color: "#fff"
                        width: theView.width * 0.25
                        wrapMode: Text.Wrap
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    width: theView.width * 0.1
                    height: 85
                    color: "transparent"

                    Row {
                        width: parent.width
                        height: 85
                        spacing: 8

                        // Item detail (dropdown)
                        Image {
                            //horizontalAlignment: Image.AlignRight
                            width: 30
                            height: 30
                            source: "assets/down.svg"
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter
                            Layout.fillWidth: true

                            MouseArea {
                                width: parent.width
                                height: parent.height
                                onClicked: albumDetail.visible = !albumDetail.visible
                                cursorShape: Qt.PointingHandCursor
                            }
                        }

                        // Remove item
                        Image {
                            //horizontalAlignment: Image.AlignRight
                            width: 30
                            height: 30
                            source: "assets/delete.svg"
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter

                            MouseArea {
                                width: parent.width
                                height: parent.height
                                onClicked: library.removeAlbum(library.albums.indexOf(modelData))
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }

                }
            }

            Rectangle {
                id: albumDetail
                width: theView.width
                height: childrenRect.height + 20
                color: "#293D52"
                visible: false
                // radius: 8

                ListView {
                    interactive: false
                    implicitWidth: parent.width
                    implicitHeight: childrenRect.height + 20
                    clip: true
                    model: modelData.tracks

                    delegate: Rectangle {
                        property int indexOfThisDelegate: index

                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: trackText.contentHeight
                        color: "transparent"

                        Text {
                            id: trackText
                            text: "%1. track: %2".arg(indexOfThisDelegate + 1).arg(modelData)
                            wrapMode: Text.WordWrap
                            font.pixelSize: 18
                            color: "#90F2F2"
                            padding: 20
                            lineHeight: 1.33
                        }
                    }
                }
            }
        }
    }
}

