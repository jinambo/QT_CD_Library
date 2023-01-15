// MyFileDialog.qml
import QtQuick 2.0
import QtQuick.Dialogs

Item {
    id: root
    property alias title: qmlFileDialog.title
    property alias file: qmlFileDialog.selectedFile
    //property alias fileUrls: qmlFileDialog.fileUrls

    signal accepted()
    signal rejected()

    function open() { qmlFileDialog.open() }
    function close() { qmlFileDialog.close() }

    FileDialog {
        id: qmlFileDialog
        modality: Qt.WindowModal
        nameFilters: ["Image File (*.png *.jpg *.bmp)"]

        onAccepted: root.accepted()
        onRejected: root.rejected()
    }
}
