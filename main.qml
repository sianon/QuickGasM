import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id:mainWindow
    visible: true
    width: 400
    height: 300
    title: "Floating Subcontrol Example"
    color: "#185abd"
    flags: Qt.FramelessWindowHint

    //QML中的方法可以被cpp调用，也可以作为槽函数
    function qml_method(val_arg){
        console.log("qml method runing",val_arg,"return ok")
        return "ok"
    }
    function showLsDialog(){
        var dialog = LsDialog.showModal();
        dialog.exec();
    }
    Frame {
        id: floating_subcontrol_left
        visible: true
        width: 65
        height: parent.height
        background: Rectangle{
            color: "#010101"
            border.color: "#21be2b"
        }
        ColumnLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                //                Layout.fillWidth: true
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                id:mybutton

                onClicked: {
                    qml_method(123);
                }
                Image {
                    anchors.fill: parent  // 图片充满整个 Rectangle 区域
                    source: "./images/back.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                }
            }
            Button {
                //                Layout.fillWidth: true
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked: {
                    qml_method(123);
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/iso.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                id:ls
                //                Layout.fillWidth: true
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // 在点击时创建并显示新窗口
                        var component = Qt.createComponent("ls_mode_dlg.qml");
                        var dialog = component.createObject(mainWindow);
                        dialog.open();
                    }
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/ls.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked: {
                    // 在点击时创建并显示新窗口
                    var component = Qt.createComponent("LsDialog.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/color.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked: {
                    var component = Qt.createComponent("param_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/param.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked: {
                    var component = Qt.createComponent("param_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/settings.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            ColumnLayout{
                Timer {
                    id: timer
                    interval: 1000  // 更新间隔为 1000 毫秒 (1 秒)
                    running: true
                    repeat: true
                    onTriggered: updateTime()

                    function padZero(value) {
                        return (value < 10) ? "0" + value : value;
                    }
                    function updateTime() {
                        var currentDate = new Date();
                        var hours = currentDate.getHours();
                        var minutes = currentDate.getMinutes();
                        var seconds = currentDate.getSeconds();

                        var formattedTime = padZero(hours) + ":" + padZero(minutes) + ":" + padZero(seconds);
                        timeLabel.text = formattedTime;
                        // 通过Qt调用UI线程更新Text元素的文本
                        //                        Qt.callLater(function() {
                        //                            timeLabel.text = + formattedTime;
                        //                        });
                    }
                }

                Text{
                    id:timeLabel
                    text: ""
                    font.pixelSize: 8
                    color: "#ffffff"
                }
            }
        }
    }
    Pane {
        id: floating_subcontrol_mid
        visible: true
        height: 65
        Layout.fillWidth: true
        anchors.left: floating_subcontrol_left.right
        anchors.bottom: floating_subcontrol_left.bottom

        background: Rectangle{
            color: "transparent"
            //            border.color: "#21be2b"
        }
        RowLayout{
            id:grid_right
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.horizontalCenter: parent.horizontalCenter
            ColumnLayout{
                Label{
                    text: "辐射率：1.00"
                    font.pixelSize: 8
                }
                Label{
                    text: "距离：1.00"
                    font.pixelSize: 8
                }
                Label{
                    text: "环境湿度：25.0°C"
                    font.pixelSize: 8
                }
            }

            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    var component = Qt.createComponent("gas_enhance_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                text: "增强"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    qml_method(123);
                }
                text: "曝光"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    qml_method(123);
                }
                text: "锁定"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 44
                Layout.preferredHeight: 44
                onClicked: {
                    qml_method(123);
                }
                text: "激光"
            }
            //            Button {
            //                Layout.fillWidth: true
            //                Layout.preferredWidth: 44
            //                Layout.preferredHeight: 44
            //                onClicked: {
            //                    qml_method(123);
            //                }
            //                Rectangle {
            //                    implicitHeight:parent.height
            //                    implicitWidth:parent.height
            //                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
            //                    Image {
            //                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
            //                        source: "./images/take_shot.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
            //                    }
            //                }
            //            }
            //            Button {
            //                Layout.fillWidth: true
            //                Layout.preferredWidth: 44
            //                Layout.preferredHeight: 44
            //                onClicked: {
            //                    qml_method(123);
            //                }
            //                Rectangle {
            //                    implicitHeight:parent.height
            //                    implicitWidth:parent.height
            //                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
            //                    Image {
            //                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
            //                        source: "./images/record.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
            //                    }
            //                }
            //            }
            //            Button {
            //                Layout.fillWidth: true
            //                Layout.preferredWidth: 44
            //                Layout.preferredHeight: 44
            //                onClicked: {
            //                    qml_method(123);
            //                }
            //                Rectangle {
            //                    implicitHeight:parent.height
            //                    implicitWidth:parent.height
            //                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
            //                    Image {
            //                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
            //                        source: "./images/playback.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
            //                    }
            //                }
            //            }
        }
    }

    Pane {
        id: floating_subcontrol_right
        visible: true
        width: 65
        height: parent.height
        anchors.right: parent.right
        background: Rectangle{
            color: "#20232c"
            border.color: "#21be2b"
        }
        ColumnLayout{
            id:grid_pane_right
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.fill: parent
            //            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 47
                Layout.preferredHeight: 47
                onClicked: {
                    qml_method(123);
                }
                text: "模式切换"
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 47
                Layout.preferredHeight: 47
                onClicked: {
                    qml_method(123);
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/take_shot.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 47
                Layout.preferredHeight: 47
                onClicked: {
                    qml_method(123);
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/record.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.preferredWidth: 47
                Layout.preferredHeight: 47
                onClicked: {
                    qml_method(123);
                }
                Rectangle {
                    implicitHeight:parent.height
                    implicitWidth:parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image {
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/playback.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
        }
    }
}
