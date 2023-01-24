import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ListView {
    property string filter: library.filter
    property var filteredAlbums

    function filterAlbums(term) {
        const albums = library.albums;

        // If extended search is enabled
        if (term.includes("?")) {
            const re = /(\w+):\s*(?:"([^"]*)"|(\S+))/g;
            let dict = {}, m;

            while (m = re.exec(term)) {
              dict[m[1]]=(m[3] || m[2]);
            }

            return albums.filter(dict.author ? a => a.author.toLowerCase().includes(dict.author.toLowerCase()) : a => a)
                .filter(dict.genre ? a => a.genre.toLowerCase().includes(dict.genre.toLowerCase()): a => a)
                .filter(dict.year ? a => String(a.date) === String(dict.year) : a => a);

        } else {
            return albums.filter(a => a.title.toLowerCase().includes(term.toLowerCase()));
        }
    }

    onFilterChanged: {
        filteredAlbums = filterAlbums(filter);
    }

    id: theView
    clip: true
    model: filter ? filteredAlbums : library.albums
    spacing: 10

    delegate: Rectangle {
        id: dataWrapper
        implicitWidth: theView.width
        implicitHeight: childrenRect.height
        color: "#253546"
        radius: 8
        clip: true

        ColumnLayout {
            width: theView.width

            RowLayout {
                width: parent.implicitWidth
                Rectangle { width: 5; height: 20; color: "transparent" }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    height: 85
                    color: "transparent"

                    Image {
                        width: 65
                        height: 65
                        source: "file:///" + modelData.imgUrl
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                ColumnItem { colWidth: 2; title: modelData.title }
                ColumnItem { colWidth: 2; title: modelData.author }
                ColumnItem { colWidth: 1; title: modelData.date }
                ColumnItem { colWidth: 2; title: modelData.genre }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    height: 85
                    color: "transparent"

                    Row {
                        width: parent.width
                        height: 85
                        spacing: 8
                        layoutDirection: Qt.RightToLeft

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

                        // Edit item
                        Image {
                            //horizontalAlignment: Image.AlignRight
                            width: 30
                            height: 30
                            source: "assets/edit.svg"
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter

                            MouseArea {
                                width: parent.width
                                height: parent.height
                                // onClicked: library.removeAlbum(library.albums.indexOf(modelData))
                                onClicked: createPopup.edit(modelData)
                                cursorShape: Qt.PointingHandCursor
                            }
                        }

                        // Item detail (dropdown)
                        Image {
                            //horizontalAlignment: Image.AlignRight
                            width: 30
                            height: 30
                            source: "assets/down.svg"
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter
                            //Layout.fillWidth: true
                            visible: modelData.tracks.length > 0
                            rotation: albumDetail.visible ? 180 : 0

                            MouseArea {
                                width: parent.width
                                height: parent.height
                                onClicked: albumDetail.visible = !albumDetail.visible
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }

                }

                Rectangle { width: 5; height: 20; color: "transparent" }
            }

            Rectangle {
                id: albumDetail
                width: theView.width
                implicitHeight: childrenRect.height + 10
                color: "#293D52"
                visible: false
                //radius: 8

                ListView {
                    interactive: false
                    implicitWidth: parent.width
                    implicitHeight: childrenRect.height + 10
                    clip: true
                    model: modelData.tracks

                    delegate: Rectangle {
                        property int indexOfThisDelegate: index

                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: trackText.height
                        color: "transparent"

                        Text {
                            id: trackText
                            text: "%1. track: %2".arg(indexOfThisDelegate + 1).arg(modelData)
                            wrapMode: Text.WordWrap
                            font.pixelSize: 18
                            color: "#90F2F2"
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 10
                            //lineHeight: 1.33
                        }
                    }
                }
            }
        }
    }
}

