import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.1

Dialog{
    id: dialog_preview
    modal: true
    width: 760
    height: 460
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background: Rectangle{
        color: "#010101"
    }

    Component.onCompleted:{
        closing.connect(closingHandler);
        var file_list = providers.mvPreviewMediaByPath(models.get(gridView.currentIndex).path);
//        providers
    }

    function closingHandler() {
            // 在窗口关闭之前执行一些操作
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
        anchors.left: parent.left
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter

        Rectangle{
            radius: 5
            color: "#3c3f41"
            width: 736
            height: 400
            Layout.alignment: Qt.AlignHCenter

            ColumnLayout{
                anchors.fill: parent
                anchors.topMargin: 5
                Image{
                    source: "file://" + models.get(gridView.currentIndex).path;
                    Layout.preferredWidth: 736
                    Layout.preferredHeight: 400
                    Layout.alignment: Qt.AlignHCenter
                }
                Text{
                    text: name
                    color: "#fff"
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        RowLayout{
            //            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignHCenter
            visible: true

            Button{
                text: "返回"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                    dialog_preview.close();
                }
            }
        }
    }
}
