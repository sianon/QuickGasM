import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.1
import QtMultimedia 5.15

Dialog {
    id: dialog_preview
    width: 800
    height: 480
    padding: 0
    Rectangle {
        color: "#333333"
        anchors.fill: parent
    }
    property string picPath: ""
        Component.onCompleted: {
            var file = models.get(gridView.currentIndex).path;
            var start = file.lastIndexOf("/");
            var end = file.lastIndexOf(".");
            if (start !== -1)
            {
                picPath = file.substring(start + 1, end);
            }
            name.text = picPath;
        }

        function closingHandler()
        {
            providers.mvStopPreviewMediaByPath();
        }
        function hideVideoBtn()
        {
            volumn.visible = false;
            snapshot.visible = false;
        }
        Timer {
            id: closingTimer
            interval: 500
            running: false
            repeat: false
            onTriggered: {
                providers.mvPlayPreviewMediaByPath();
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 0
            Rectangle {
                color: "#333333"
                width: 800
                height: 400
                Layout.alignment: Qt.AlignHCenter
                RowLayout {
                    ColumnLayout {
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 20
                        Button {
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 25
                            background: Image {
                                anchors.fill: parent
                                source: "../images/left.png"
                            }
                            onClicked: {
                                mediaPlayer.stop();
                                dialog_preview.close();
                            }
                        }
                        Item {
                            Layout.preferredHeight: 123
                        }
                        Button {
                            Layout.preferredHeight: 40
                            Layout.preferredWidth: 40
                            background: Image {
                                anchors.fill: parent
                                source: "../images/left_page.png"
                            }
                            onClicked: {
                                mediaPlayer.stop();
                                dialog_preview.close();
                            }
                        }
                    }
                    ColumnLayout {
                        Layout.topMargin: 10
                        Rectangle {
                            id: imgItem_back
                            Layout.preferredWidth: 710
                            Layout.preferredHeight: 360
                            color: "#000"
                            Image {
                                id: img_preview
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                        MediaPlayer {
                            id: mediaPlayer
                            Component.onCompleted: {
                                mediaPlayer.play();
                            }
                        }
                        Rectangle {
                            id: videoItem_back
                            Layout.preferredWidth: 710
                            Layout.preferredHeight: 360
                            color: "#000"
                            VideoOutput {
                                id: videoItem
                                anchors.fill: parent
                                source: mediaPlayer
                            }
                            MouseArea {
                                id: controlArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (mediaPlayer.playbackState === MediaPlayer.PlayingState)
                                    {
                                        mediaPlayer.pause();
                                        console.log("pause");
                                    } else {
                                    mediaPlayer.play();
                                    console.log("play");
                                }
                                console.log(mediaPlayer.playbackState);
                            }
                        }
                        Image {
                            id: playButton
                            source: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "../images/pause.png" : "../images/play.png"
                            width: 64
                            height: 64
                            anchors.centerIn: parent
                            visible: controlArea.containsMouse
                        }
                    }
                    Text {
                        id: name
                        text: "picPath"
                        color: "#fff"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
                ColumnLayout {
                    Button {
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        background: Image {
                            anchors.fill: parent
                            source: "../images/right_page.png"
                        }
                        onClicked: {
                            mediaPlayer.stop();
                            dialog_preview.close();
                        }
                    }
                }
                Component.onCompleted: {
                    var file = models.get(gridView.currentIndex).path;
                    var start = file.lastIndexOf("/");
                    var end = file.lastIndexOf(".");
                    if (start !== -1)
                    {
                        picPath = file.substring(start + 1, end);
                    }
                    name.text = picPath;
                    if (file.endsWith(".mp4"))
                    {
                        videoItem_back.visible = true;
                        imgItem_back.visible = false;
                        mediaPlayer.source = "file://" + file;
                    }else {
                    videoItem_back.visible = false;
                    imgItem_back.visible = true;
                    mediaPlayer.source = "";
                    img_preview.source = "file://" + file;
                }
            }
        }
    }
    Rectangle {
        color: "#797979"
        Layout.preferredHeight: 4
        Layout.preferredWidth: 800
    }
    Item {
        Layout.preferredHeight: 26
        width: 800
    }
    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        Layout.alignment: Qt.AlignHCenter
        visible: true
        spacing: 50
        Button {
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            background: Image {
                anchors.fill: parent
                source: "../images/edit.png"
            }
            onClicked: {
                mediaPlayer.stop();
                dialog_preview.close();
            }
        }
        Button {
            id: snapshot
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            background: Image {
                anchors.fill: parent
                source: "../images/snapshot.png"
            }
            onClicked: {
            }
        }
        Button {
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            background: Image {
                anchors.fill: parent
                source: "../images/upload.png"
            }
            onClicked: {
                var component = Qt.createComponent("messagebox.qml");
                var dlg = component.createObject(mainWindow);
                dlg.title = "上传成功"
            }
        }
        Button {
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            background: Image {
                anchors.fill: parent
                source: "../images/bluetooth.png"
            }
            onClicked: {
                var component = Qt.createComponent("messagebox.qml");
                var dlg = component.createObject(mainWindow);
                dlg.title = "蓝牙未开启，是否立即开启蓝牙？ \n 开启后请进行蓝牙配对"
            }
        }
        Button {
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            background: Image {
                anchors.fill: parent
                source: "../images/delete.png"
            }
            onClicked: {
                var component = Qt.createComponent("messagebox.qml");
                var dlg = component.createObject(mainWindow);
                dlg.title = "确定删除？"
            }
        }
        CheckBox {
            id: volumn
            implicitWidth: 40
            implicitHeight: 40

            indicator: Image {
                anchors.fill: parent
                source: volumn.checked ? "../images/mute.png" : "../images/open.png"
            }
        }
    }
}
}
