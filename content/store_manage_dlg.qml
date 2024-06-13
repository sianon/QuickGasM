import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
    width: 800
    height: 480
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    property int freeSpace: 80
    property int usedSpace: 80
    property int totalSpace: 80
    Rectangle {
        color: "#7f7f7f"
        radius: 13
        height: 150
        width: 300
        anchors.centerIn: parent
        ColumnLayout{
            anchors.fill: parent
            Text {
                text: "TF存储卡"
                font.pixelSize: 14
                color: "#ffffff"
                Layout.alignment: Qt.AlignLeft
            }
            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                Text {
                    text: "68"
                    font.pixelSize: 38
                    font.bold: true
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignLeft
                }
                Text {
                    text: "GB"+"可用"
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                Text {
                    text: "可用空间"
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignLeft
                }
                Text {
                    text: "68"+"GB"
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    text: "总容量"
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignLeft
                }
                Text {
                    text: "128"+"GB"
                    color: "#ffffff"
                    font.pixelSize: 14
                }
            }
            Button {
                text: "格式化"
                Layout.preferredHeight: 25
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
