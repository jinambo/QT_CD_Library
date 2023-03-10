import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import AlbumLib 1.0

Popup {
    property bool isNew: true
    property var albumData
    readonly property var textFieldsList: [titleIn, authorIn, genreIn, dateIn, imgUrlIn]
    // TODO: namapovat properties pro edit alba
    // property string title: ""
    // property string author: ""

    // Fill Text Fields with data from the clicked item
    function edit(data) {
        isNew = false;

        albumData = data

        titleIn.textItem.text = data.title;
        authorIn.textItem.text = data.author;
        dateIn.textItem.text = data.date;
        genreIn.textItem.text = data.genre;
        imgUrlIn.textItem.text = data.imgUrl;
        album.setTracks(data.tracks);

        open();
    }

    function create() {
        isNew = true;

        // Clear text fields
        textFieldsList.forEach(item => item.textItem.text = "");
        album.setTracks([]);

        open();
    }

    function submitCreate() {
        // TODO: mozny memory leak -> proverit
        /*
        album.initAlbum(
            titleIn.textItem.text,
            authorIn.textItem.text,
            dateIn.textItem.text,
            genreIn.textItem.text
        )*/

        library.addAlbum(
            imgUrlIn.textItem.text,
            titleIn.textItem.text,
            authorIn.textItem.text,
            dateIn.textItem.text,
            genreIn.textItem.text,
            album.tracks
        );

        textFieldsList.forEach(item => item.textItem.text = "");

        createPopup.close();
    }

    function submitEdit() {
        // TODO: edit album
        console.log("Edit album fired");

        library.editAlbum(
            library.albums.indexOf(albumData),
            imgUrlIn.textItem.text,
            titleIn.textItem.text,
            authorIn.textItem.text,
            dateIn.textItem.text,
            genreIn.textItem.text,
            album.tracks
        );

        textFieldsList.forEach(item => item.textItem.text = "");

        createPopup.close();
    }

    width: parent.width
    height: parent.height

    background: Rectangle {
        color: "transparent"
    }

    Album {
        id: album

        Component.onCompleted: {
            console.log('Component completed' + album.title)
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        opacity: 0.5
        color: "#2C3E50"
    }

    Rectangle {
        id: popupContainer
        width: parent.width * 0.9
        height: parent.height * 0.9
        color: "#253546"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        radius: 8

        Rectangle {
            id: popupWrapper
            width: parent.width - 80
            height: parent.height - 80
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            ColumnLayout {
                width: popupWrapper.width
                height: popupWrapper.height
                //Layout.alignment: Qt.AlignTop

                Text {
                    text: isNew ? "Create a new album" : "Edit album"
                    font.pixelSize: 32
                    color: "#90F2F2"
                }

                RowLayout {
                    Rectangle {
                        implicitWidth: popupWrapper.width / 2
                        implicitHeight: childrenRect.height
                        Layout.alignment: Qt.AlignTop
                        color: "transparent"

                        ColumnLayout {
                            id: infoCol
                            width: parent.width
                            spacing: 20

                            Text {
                                text: "Album information"
                                topPadding: 20
                                font.pixelSize: 24
                                color: "#90F2F2"
                            }

                            Input { id: titleIn; title: "Title" }
                            Input { id: authorIn; title: "Author" }
                            Input { id: genreIn; title: "Genre" }
                            Input { id: dateIn; title: "Date (year)" }
                            RowLayout {
                                Input { id: imgUrlIn; title: "Picture"; fullWidth: false; canEdit: false; Layout.alignment: Qt.AlignBottom; }
                                Button {
                                    implicitWidth: infoCol.width * 0.3
                                    Layout.alignment: Qt.AlignBottom

                                    CustomDialog {
                                        id: saveFileDialog
                                        title: qsTr("Choose album's picture ...")
                                        onRejected: {
                                            console.log("Canceled")
                                        }
                                        onAccepted: {
                                            const fullPath = String(file).replace("file://", "")
                                            imgUrlIn.textItem.text = fullPath
                                        }
                                    }

                                    onClicked: {
                                        saveFileDialog.open()
                                    }

                                    contentItem: Text {
                                        text: "Upload"
                                        font.pixelSize: 18
                                        topPadding: 3.5
                                        bottomPadding: 3.5
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    background: Rectangle {
                                        color: parent.down ? "#6ED1D1" :
                                                (parent.hovered ? "#6ED1D1" : "#90F2F2")
                                        radius: 8
                                    }
                                }
                            }

                        }
                    }

                    Rectangle {
                        implicitWidth: popupWrapper.width / 2
                        implicitHeight: popupWrapper.childrenRect
                        Layout.alignment: Qt.AlignTop

                        ColumnLayout {
                            id: trackCol
                            width: parent.width
                            spacing: 20

                            Text {
                                text: "Album's tracks"
                                topPadding: 20
                                font.pixelSize: 24
                                color: "#90F2F2"
                            }

                            RowLayout {
                                Input { id: trackIn; title: "Track title"; fullWidth: false; Layout.alignment: Qt.AlignBottom }
                                Button {
                                    implicitWidth: infoCol.width * 0.3
                                    Layout.alignment: Qt.AlignBottom

                                    onClicked: {
                                        album.addTrack(trackIn.textItem.text)
                                        trackIn.textItem.text = ""
                                    }

                                    contentItem: Text {
                                        text: "Add track"
                                        font.pixelSize: 18
                                        topPadding: 3.5
                                        bottomPadding: 3.5
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    background: Rectangle {
                                        color: parent.down ? "#6ED1D1" :
                                                (parent.hovered ? "#6ED1D1" : "#90F2F2")
                                        radius: 8
                                    }
                                }
                            }

                            Text {
                                text: "Track list"
                                topPadding: 20
                                font.pixelSize: 16
                                color: "#90F2F2"
                            }

                            ListView {
                                id: tracksList
                                clip: true
                                model: album.tracks
                                spacing: 5
                                implicitWidth: infoCol.width
                                implicitHeight: infoCol.height

                                delegate: Row {
                                    property int indexOfThisDelegate: index

                                    Image {
                                        width: 24
                                        height: 24
                                        source: "assets/delete.svg"
                                        fillMode: Image.PreserveAspectFit

                                        MouseArea {
                                            width: parent.width
                                            height: parent.height
                                            onClicked: album.removeTrack(album.tracks.indexOf(modelData))
                                            cursorShape: Qt.PointingHandCursor
                                        }
                                    }

                                    Text {
                                        text: "%1. %2".arg(indexOfThisDelegate + 1).arg(modelData)
                                        color: "#fff"
                                        font.bold: true
                                        font.pixelSize: 16
                                        leftPadding: 10
                                        topPadding: 3
                                    }

                                }
                            }
                        }
                    }
                }

                Row {
                    //Layout.alignment: Qt.AlignRight
                    Layout.topMargin: 40
                    spacing: 10
                    Layout.alignment: Qt.AlignRight | Qt.AlignBottom

                    Button {
                        width: 200
                        height: 48
                        onClicked: createPopup.close()

                        contentItem: Text {
                            text: "Cancel"
                            font.pixelSize: 20
                            color: parent.down ? "#eee" :
                                    (parent.hovered ? "#fff" : "#E74C3C")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            color: parent.down ? "#c93728" :
                                    (parent.hovered ? "#E74C3C" : "transparent")
                            radius: 8
                            border.color: "#E74C3C"
                            border.width: 2
                        }

                    }

                    Button {
                        text: isNew ? "Create" : "Edit"
                        font.pixelSize: 20
                        width: 200
                        height: 48
                        onClicked: isNew ? submitCreate() : submitEdit()
                        background: Rectangle {
                            color: parent.down ? "#6ED1D1" :
                                    (parent.hovered ? "#6ED1D1" : "#90F2F2")
                            radius: 8
                        }
                    }
                }
            }
        }

    }
}
