import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.1
import QtMultimedia 5.15

Item{
    id: dialog_preview
    width: 800
    height: 480

    Rectangle{
        color: "#333333"
        anchors.fill: parent
    }

    Component.onCompleted:{
    }

    function closingHandler() {
        providers.mvStopPreviewMediaByPath();
    }

    Timer{
        id: closingTimer
        interval: 500
        running: false
        repeat: false
        onTriggered:{
            providers.mvPlayPreviewMediaByPath();
        }
    }

    ColumnLayout{
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter

        Rectangle{
            color: "#333333"
            width: 800
            height: 400
            Layout.alignment: Qt.AlignHCenter
            RowLayout{
                ColumnLayout{
                    Layout.alignment: Qt.AlignTop
                    Button{
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        background: Image {
                            anchors.fill: parent
                            source: "../images/back.png"
                        }
                        onClicked:{
                            mediaPlayer.stop();
                            dialog_preview.close();
                        }
                    }
                    Item{
                        Layout.preferredHeight: 80
                    }
                    Button{
//                        text: "<"
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        background: Image {
                            anchors.fill: parent
                            source: "../images/left_page.png"
                        }
                        onClicked:{
                            mediaPlayer.stop();
                            dialog_preview.close();
                        }
                    }
                }
                ColumnLayout{
                    Image{
                        id: img_preview
                        Layout.preferredWidth: 710
                        Layout.preferredHeight: 360
                        Layout.alignment: Qt.AlignHCenter
                    }

                    MediaPlayer{
                        id: mediaPlayer
                        Component.onCompleted:{
                            mediaPlayer.play();
                        }
                    }
                    VideoOutput{
                        id: videoItem
                        anchors.fill: parent
                        source: mediaPlayer
                    }

                    Text{
                        text: "name"
                        color: "#fff"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
                ColumnLayout{
                    Button{

                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        background: Image {
                            anchors.fill: parent
                            source: "../images/right_page.png"
                        }
                        onClicked:{
                            mediaPlayer.stop();
                            dialog_preview.close();
                        }
                    }
                }
                Component.onCompleted:{
                }
            }
        }
        Rectangle{
            color: "#797979"
            Layout.preferredHeight: 4
            Layout.preferredWidth: 800
        }
        Item{
            Layout.preferredHeight: 10
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.alignment: Qt.AlignHCenter
            visible: true
            spacing: 50
            Button{
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                background: Image {
                    anchors.fill: parent
                    source: "../images/edit.png"
                }
                onClicked:{
                    mediaPlayer.stop();
                    dialog_preview.close();
                }
            }
            Button{
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                background: Image {
                    anchors.fill: parent
                    source: "../images/upload.png"
                }
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(dialog_preview);
                    dlg.title = "上传成功"
                    dlg.show();
                }
            }
            Button{
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                background: Image {
                    anchors.fill: parent
                    source: "../images/bluetooth.png"
                }
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(dialog_preview);
                    dlg.title = "蓝牙未开启，是否立即开启蓝牙？ \n 开启后请进行蓝牙配对"
                    dlg.show();
                }
            }
            Button{
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                background: Image {
                    anchors.fill: parent
                    source: "../images/delete.png"
                }
                onClicked:{
                    var component = Qt.createComponent("messagebox.qml");
                    var dlg = component.createObject(dialog_preview);
                    dlg.title = "确定删除？"
                    dlg.show();
                }
            }
        }
    }
}
