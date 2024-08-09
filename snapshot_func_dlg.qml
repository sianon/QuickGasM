import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    modal: true
    width: 310
    height: 200
    padding: 0
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background:Rectangle{
        anchors.fill: parent
        color: "#333333"
    }

    function colorTempletChange(val_arg){
        providers.mvSetColorType(val_arg);
        console.log("colorTempletChange", val_arg, "return ok");
        return "ok";
    }

    ColumnLayout{
        width: 310
        // anchors.fill: parent
        ColumnLayout{
            Layout.fillWidth: true
            // anchors.horizontalCenter: parent.horizontalCenter
            Text{
                Layout.alignment: Qt.AlignLeft
                text: "拍照图片设置"
                font.pixelSize: 20
                Layout.leftMargin: 16
                color: "#ffffffff"
            }
            Rectangle{
                Layout.fillWidth: true
                height: 4
                color: "#797979"
            }
        }
        RowLayout{
            // anchors.horizontalCenter: parent.horizontalCenter
Layout.fillWidth: true
Layout.alignment: Qt.AlignHCenter
            Text{
                Layout.alignment: Qt.AlignLeft
                text: "图片名称"
                color: "#ffffffff"
            }
            TextField{
                Layout.preferredWidth: 190
                color: "#797979"
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 30
            Text{
                Layout.alignment: Qt.AlignLeft
                text: "信息写入"
                color: "#ffffffff"
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.margins: 0
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "images/mic.png"
                    }
                }
                onClicked:{
                    providers.mbSnapRecordVoice("");
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.margins: 0
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "images/Beidou.png"
                    }
                }
                onClicked:{
                    providers.mbSnapBeidouInfo();
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.margins: 0
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "images/qr_scan.png"
                    }
                }
                onClicked:{
                    providers.mbSnapQRScan();
                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            Layout.leftMargin: 25
            spacing: 40
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.margins: 0
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "images/save.png"
                    }
                }
                onClicked:{
                    providers.mbSnapSave("save");
                    dialog.close();
                    return "save";
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.alignment: Qt.AlignHCenter
                Layout.margins: 0
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "images/back.png"
                    }
                }
                onClicked:{
                    providers.mvCallBackMsg("cancel");
                    dialog.close();
                }
            }
        }
    }
}
