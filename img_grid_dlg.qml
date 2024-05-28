import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.1

Dialog{
    id: dialog
    modal: true
    width: 760
    height: 460
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background: Rectangle{
        color: "#010101"
    }

    function clickedImage(index){
        gridView.currentIndex = index;
        console.log("this is :", cur.name);
        console.log("this is paht:", cur.path);
        return "ok";
    }

    function doubleclickedImage(index){
        gridView.currentIndex = index;
        var cur = models.get(gridView.currentIndex);
        var component = Qt.createComponent("img_preview_dlg.qml");
        var dialog = component.createObject(mainWindow);
        dialog.open();
        console.log("this is :", cur.name);
        console.log("this is paht:", cur.path);
        return "ok";
    }
    ColumnLayout{
        anchors.left: parent.left
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter

        ListModel{
            id: models

            Component.onCompleted:{
                var file_list = providers.moGetFilePaths();

                for(var i = 0; i < file_list.length; i++){
                    var file_name = file_list[i];
                    var file_path = file_name;

                    var parts = file_name.split("/");
                    var file_name = parts[parts.length - 1];

                    var dotIndex = file_name.lastIndexOf(".");
                    if(dotIndex !== -1){
                        file_name = file_name.substring(0, dotIndex);
                    }
                    console.log("file_name:", file_name, "file_path:", file_path);
                    models.append({name: file_name, path: file_path});
                }
            }
        }

        Rectangle{
            radius: 5
            color: "#3c3f41"
            width: 736
            height: 400
            Layout.alignment: Qt.AlignHCentert

            GridView{
                id: gridView
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                model: models

                cellWidth: 179
                cellHeight: 126

                delegate: Column{
                    width: 169
                    height: 108
                    ColumnLayout{
                        anchors.fill: parent
                        anchors.topMargin: 5
                        Image{
                            source: "file://" + path
                            Layout.preferredWidth: 160
                            Layout.preferredHeight: 82
                            Layout.alignment: Qt.AlignHCenter
                            Component.onCompleted:{
                                if(path.endsWith(".mp4")){
                                    source = "file://" + providers.mvGetVideoThumbnailByPath(path);
                                }
                            }
                        }
                        Text{
                            text: name
                            color: "#fff"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea{
                        anchors.fill: parent; onClicked:{
                            clickedImage(index)
                        }
                        onDoubleClicked:{
                            doubleclickedImage(index);
                            //                            models.remove(index)
                        }
                    }
                }
                highlight: Rectangle{
                    color: "lightsteelblue"; radius: 5
                }
                focus: true
            }
        }

        GridLayout{
            columns: 4
            width: 736
            height: 400
            visible: false
            Layout.alignment: Qt.AlignHCenter
            Rectangle{
                radius: 5 // 设置圆角大小
                color: "#3c3f41"
                anchors.fill: parent
            }
        }
        RowLayout{
            //            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignHCenter
            visible: true
            Button{
                text: "删除"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignHCenter
                onClicked:{
                    var cur = models.get(gridView.currentIndex);

                    console.log("this is :", cur.name);
                    console.log("this is paht:", cur.path);
                    providers.mvDeleteFile(cur.path);
                    models.remove(gridView.currentIndex);
                }
            }
            Button{
                text: "查看"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                    var cur = models.get(gridView.currentIndex);
                    var component = Qt.createComponent("img_preview_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
            }
            Button{
                text: "导出"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                }
            }
            Button{
                text: "重命名"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                }
            }
            Button{
                text: "返回"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked:{
                    dialog.close();
                }
            }
        }
    }
}
