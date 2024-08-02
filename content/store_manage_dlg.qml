import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property int freeSpace: 0
    property int usedSpace: 0
    property int totalSpace: 0

    width: 800
    height: 436
    //    property var info: providers.mobGetStorageInfo()
    Component.onCompleted: {
        var info = providers.mobGetStorageInfo();
        var obj = JSON.parse(info);
        freeSpace = obj.free;
        usedSpace = obj.used;
        totalSpace = obj.total;
    }

    Rectangle {
        color: "#333333"
        anchors.fill: parent
    }

    Rectangle {
        color: "#7f7f7f"
        radius: 13
        height: 250
        width: 580
        anchors.centerIn: parent

        ColumnLayout {
            anchors.fill: parent

            Text {
                Layout.preferredHeight: 26
                text: "TF存储卡"
                font.pixelSize: 20
                color: "#ffffff"
                Layout.alignment: Qt.AlignLeft
            }

            Rectangle {
                color: "#ffffff"
                height: 4
                width: parent.width
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 35

                Text {
                    text: freeSpace
                    font.pixelSize: 66
                    font.bold: true
                    color: "#ffffff"
                }

                Text {
                    text: "GB" + "可用"
                    font.pixelSize: 14
                    color: "#ffffff"
                }

            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Text {
                    text: "已用："
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignLeft
                }

                Text {
                    text: freeSpace + "GB"
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignHCenter
                }

                Item {
                    height: 1
                    width: 40
                }

                Text {
                    text: "总容量："
                    font.pixelSize: 14
                    color: "#ffffff"
                    Layout.alignment: Qt.AlignLeft
                }

                Text {
                    text: totalSpace + "GB"
                    color: "#ffffff"
                    font.pixelSize: 14
                }

            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                RoundButton {
                    //                        upgradeMsgBox.close();
                    //                        var component = Qt.createComponent("noticebox.qml");
                    //                        var dlg = component.createObject(mainWindow);
                    //                        dlg.title = "升级失败，请重新升级！"
                    //                        dlg.show();

                    text: "查看TF卡文件"
                    width: 80
                    onClicked: {
                        onClicked: stackView.push(Qt.resolvedUrl("explore.qml"))
                    }

                    background: Rectangle {
                        implicitWidth: 160
                        implicitHeight: 40
                        radius: 20
                        opacity: enabled ? 1 : 0.3
                        color: "#169bd5"
                    }

                }

                Item {
                    height: 1
                    width: 60
                }

                RoundButton {
                    text: "格式化"
                    width: 80
                    onClicked: {
                        var component = Qt.createComponent("format_msgbox.qml");
                        var dlg = component.createObject(mainWindow);
                    }

                    background: Rectangle {
                        implicitWidth: 160
                        implicitHeight: 40
                        radius: 20
                        opacity: enabled ? 1 : 0.3
                        color: "#d9001b"
                    }

                }

            }

        }

    }

}
