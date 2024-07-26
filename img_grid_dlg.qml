import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.1

Dialog {
    id: dialog
    modal: true
    width: 800
    height: 480
    padding: 0
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    property bool isvideo: false
        background: Rectangle {
            color: "#333333"
        }
        function clickedImage(index)
        {
            gridView.currentIndex = index;
            console.log("this is :", cur.name);
            console.log("this is paht:", cur.path);
            return "ok";
        }

        function setVideoModel(val)
        {
            var file_list = providers.moGetFilePaths();
            isvideo = val;
            for (var i = 0; i < file_list.length; i++) {
                var file_name = file_list[i];
                var file_path = file_name;

                var parts = file_name.split("/");
                var file_name = parts[parts.length - 1];

                var dotIndex = file_name.lastIndexOf(".");
                if (dotIndex !== -1)
                {
                    file_name = file_name.substring(0, dotIndex);
                }
                console.log("file_name:", file_name, "file_path:", file_path);
                console.log("isvideo:", isvideo);
                if (isvideo)
                {
                    if (file_path.indexOf("mp4") !== -1)
                    {
                        console.log("includes:", file_path);
                        models.append({name: file_name, path: file_path, selected: true});
                    }
                }else {
                if (file_path.indexOf("mp4") !== -1)
                {
                    continue;
                }
                models.append({name: file_name, path: file_path, selected: true});
            }
        }
    }
    function doubleclickedImage(index)
    {
        gridView.currentIndex = index;
        var cur = models.get(gridView.currentIndex);
        //        var component = Qt.createComponent("img_preview_dlg.qml");
        var component = Qt.createComponent("content/pic_preview_dlg.qml");
        var dialog = component.createObject(mainWindow);
        if (!isvideo)
        {
            dialog.hideVideoBtn();
        }
        dialog.open();
        console.log("this is :", cur.name);
        console.log("this is paht:", cur.path);
        return "ok";
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        RowLayout {
            Layout.topMargin: 5
            Layout.leftMargin: 5
            Button {
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.margins: 0
                Rectangle {
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image {
                        anchors.fill: parent
                        source: "images/left.png"
                    }
                }
                onClicked: {
                    dialog.close();
                }
            }
            Text {
                Layout.alignment: Qt.AlignLeft
                text: isvideo ? "视频" : "照片"
                font.pixelSize: 20
                Layout.leftMargin: 16
                color: "#ffffffff"
            }
            Item {
                Layout.fillWidth: true
                height: 6
                Rectangle {
                    anchors.fill: parent
                    color: "#333333"
                    width: parent.width
                }
            }
            RowLayout {
                Button {
                    Layout.preferredWidth: 46
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 10
                    background: Rectangle {
                        color: parent.hovered ? "#4d4d4d" : "#333333"
                    }
                    contentItem: Text {
                        text: "多选"
                        color: "white"
                    }
                    onClicked: {
                        dialog.close();
                    }
                }
                Button {
                    Layout.preferredWidth: 46
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 10
                    background: Rectangle {
                        color: parent.hovered ? "#4d4d4d" : "#333333"
                    }
                    contentItem: Text {
                        text: "全选"
                        color: "white"
                    }
                    onClicked: {
                        for (var i = 0; i < models.count; ++i) {
                            models.get(i).selected = true;
                            console.log("selected is :", models.get(i).selected);
                            console.log("this is :", models.get(i).name);
                        }
                    }
                }
                Button {
                    Layout.preferredWidth: 78
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 10
                    background: Rectangle {
                        color: parent.hovered ? "#4d4d4d" : "#333333"
                    }
                    contentItem: Text {
                        text: "取消选择"
                        color: "white"
                    }
                    onClicked: {
                        for (var i = 0; i < models.count; ++i) {
                            models.get(i).selected = false;
                            console.log("selected is :", models.get(i).selected);
                            console.log("this is :", models.get(i).name);
                        }
                    }
                }
            }
        }
        Item {
            Layout.fillWidth: true
            height: 4
            Rectangle {
                anchors.fill: parent
                color: "#d7d7d7"
                width: parent.width
            }
        }
        Item {
            Layout.fillWidth: true
            height: 6
            Rectangle {
                anchors.fill: parent
                color: "#333333"
                width: parent.width
            }
        }
        RowLayout {
            Layout.fillWidth: true
            RowLayout {
                Layout.preferredWidth: 500
                Layout.preferredHeight: 50
                Layout.leftMargin: 10
                spacing: 0
                Rectangle {
                    anchors.fill: parent
                    color: "#3e3e3e"
                    radius: 25
                    width: parent.width
                }
                Button {
                    Layout.preferredWidth: 36
                    Layout.preferredHeight: 36
                    //                Layout.alignment: Qt.AlignHCenter
                    Layout.leftMargin: 10
                    Rectangle {
                        implicitHeight: parent.height
                        implicitWidth: parent.height
                        color: "#3e3e3e"
                        Image {
                            anchors.fill: parent
                            source: "images/search.png"
                        }
                    }
                    onClicked: {
                        dialog.close();
                    }
                }
                TextField {
                    id: search_text
                    Layout.preferredWidth: 500
                    Layout.preferredHeight: 50
                    //                Layout.alignment: Qt.AlignHCenter
                    text: isvideo ? "输入视频名称进行搜索" : "输入拍照时间、照片名称进行搜索"
                    font.pixelSize: 20
                    color: "#8e8e93"
                    background: Rectangle {
                        color: "#3e3e3e"
                        radius: 25
                    }
                    padding: 5
                }

            }
            RowLayout {
                Button {
                    Layout.preferredWidth: 46
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 10
                    background: Rectangle {
                        color: parent.hovered ? "#4d4d4d" : "#333333"
                    }
                    contentItem: Text {
                        text: "删除"
                        color: "white"
                    }
                    onClicked: {
                        dialog.close();
                    }
                }
                Button {
                    Layout.preferredWidth: 46
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 10
                    background: Rectangle {
                        color: parent.hovered ? "#4d4d4d" : "#333333"
                    }
                    contentItem: Text {
                        text: "上传"
                        color: "white"
                    }
                    onClicked: {
                        dialog.close();
                    }
                }
                Button {
                    Layout.preferredWidth: 78
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 10
                    background: Rectangle {
                        color: parent.hovered ? "#4d4d4d" : "#333333"
                    }
                    contentItem: Text {
                        text: "蓝牙传输"
                        color: "white"
                    }
                    onClicked: {
                        dialog.close();
                    }
                }
            }
        }
        ListModel {
            id: models
        }

        Rectangle {
            color: "#333333"
            width: 800
            height: 378
            Layout.alignment: Qt.AlignHCentert
            GridView {
                id: gridView
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                model: models
                cellWidth: 130
                cellHeight: 130

                delegate: Item {
                    width: 130
                    height: 130
                    //                    Rectangle {
                    //                        width: parent.width
                    //                        height: parent.height
                    //                        color: models.selected ? "lightblue" : "gray"
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.topMargin: 5
                        visible: true
                        Image {
                            source: "file://" + path
                            Layout.preferredWidth: 92
                            Layout.preferredHeight: 92
                            Layout.alignment: Qt.AlignHCenter
                            Component.onCompleted: {
                                if (path.endsWith(".mp4"))
                                {
                                    source = "file://" + providers.mvGetVideoThumbnailByPath(path);
                                }
                            }
                        }
                        Text {
                            text: name
                            color: "#fff"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            //                                models.selected = !models.selected;
                            clickedImage(index);
                        }
                        onDoubleClicked: {
                            doubleclickedImage(index);
                            //                            models.remove(index)
                        }
                    }
                    //                    }
                }
                highlight: Rectangle {
                    color: "#7f7f7f"
                    radius: 5
                }
                focus: true
            }
        }

        //        GridLayout {
        //            columns: 4
        //            width: 736
        //            height: 400
        //            visible: false
        //            Layout.alignment: Qt.AlignHCenter
        //            Rectangle {
        //                radius: 5
        //                color: "#3c3f41"
        //                anchors.fill: parent
        //            }
        //        }
        RowLayout {
            //            anchors.left: parent.left
            Layout.fillWidth: true
            Layout.preferredHeight: 20
            Layout.alignment: Qt.AlignHCenter
            visible: false
            Button {
                text: "删除"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    var cur = models.get(gridView.currentIndex);

                    console.log("this is :", cur.name);
                    console.log("this is paht:", cur.path);
                    providers.mvDeleteFile(cur.path);
                    models.remove(gridView.currentIndex);
                }
            }
            Button {
                text: "查看"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked: {
                    var cur = models.get(gridView.currentIndex);
                    var component = Qt.createComponent("img_preview_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
            }
            Button {
                text: "导出"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked: {
                }
            }
            Button {
                text: "重命名"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked: {
                }
            }
            Button {
                text: "返回"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 60
                onClicked: {
                    dialog.close();
                }
            }
        }
    }
}
