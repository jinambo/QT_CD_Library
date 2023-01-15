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

    ColumnLayout {
        width: parent.width

        Loader {
            id: searchLoader
            source: control.checked ? "ExtendedSearch.qml" : "SimpleSearch.qml"
        }

        CheckBox {
            id: control
            checked: false

            indicator: Rectangle {
                implicitWidth: 18
                implicitHeight: 18
                anchors.verticalCenter: parent.verticalCenter
                radius: 2
                border.width: 2
                border.color: "#90F2F2"
                color: "transparent"

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 6
                    height: 6
                    radius: 1
                    color: "#90F2F2"
                    visible: control.checked
                }
            }

            contentItem: Text {
                text: control.checked ? "Disable extended filter" : "Enable extended filter"
                color: "#90F2F2"
                font.pixelSize: 16
                font.weight: 500
                verticalAlignment: Text.AlignVCenter
                leftPadding: control.indicator.width
            }
        }
    }
}
