import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import Local 1.0

ApplicationWindow{
    id: mainWindow
    objectName: "mainWindow"
    visible: true
    width: 800
    height: 480
    title: "Floating Subcontrol Example"
    color: "#185abd"
    flags: Qt.FramelessWindowHint

    function zoomin(val_arg){
        providers.mvZoomIn();
        console.log("zoomin", val_arg, "return ok")
        return "ok"
    }
    function zoomout(val_arg){
        providers.mvZoomOut();
        console.log("zoomout", val_arg, "return ok")
        return "ok"
    }
    function switchRenderMode(val_arg){
        providers.mvSetRanderMode();
        console.log("qml method runing", val_arg, "return ok");
        return "ok"
    }

    function showLsDialog(){
        var component = Qt.createComponent("snapshot_func_dlg.qml");
        var dialog = component.createObject(mainWindow);
        dialog.open();
        console.log("qml showLsDialog runing", "return ok");
    }

    function snapshot(){
        providers.mbSnapShot();
        console.log("qml method runing snapshot", "return ok");
    }

    TdlasDevice{
        id: tdlas_ctrl
    }

    FrameProvider{
        id: providers
    }
    DeviceStatus{
        id: device_status
    }

    background: Rectangle{
        VideoOutput{
            id: video_outputs
            anchors.fill: parent
            source: providers
        }
        Timer{
            id: myTimer
            interval: 40
            running: true
            repeat: true

            onTriggered:{
                providers.test();
            }
        }
    }
    Frame{
        id: floating_subcontrol_left
        visible: true
        width: 65
        height: parent.height
        background: Rectangle{
            color: "#010101"
        }
        ColumnLayout{
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                //                Layout.fillWidth: true
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                id: mybutton

                onClicked:{
                    testbtn(123);
                }
                Image{
                    anchors.fill: parent
                    source: "./images/back.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                }
            }
            Button{
                //                Layout.fillWidth: true
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked:{
                    var component = Qt.createComponent("iso_dlg.qml");
                    var dialog = component.createObject(mainWindow);            
                    dialog.open();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image{
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/iso.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button{
                id: ls
                //                Layout.fillWidth: true
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        // 在点击时创建并显示新窗口
                        var component = Qt.createComponent("ls_mode_dlg.qml");
                        var dialog = component.createObject(mainWindow);
                        dialog.open();
                    }
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image{
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/ls.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button{
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked:{
                    // 在点击时创建并显示新窗口
                    var component = Qt.createComponent("color_setting_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image{
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/color.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button{
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked:{
                    var component = Qt.createComponent("param_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image{
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/param.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            Button{
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                onClicked:{
                    var component = Qt.createComponent("param_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"  // 将 Rectangle 颜色设置为透明，使得背景图片显示
                    Image{
                        anchors.fill: parent  // 图片充满整个 Rectangle 区域
                        source: "./images/settings.png"  // 图片路径，这里使用资源路径，也可以使用绝对或相对路径
                    }
                }
            }
            ColumnLayout{
                Timer{
                    id: timer
                    interval: 1000  // 更新间隔为 1000 毫秒 (1 秒)
                    running: true
                    repeat: true
                    onTriggered: updateTime()

                    function padZero(value){
                        return (value < 10) ? "0" + value : value;
                    }

                    function updateTime(){
                        var currentDate = new Date();
                        var hours = currentDate.getHours();
                        var minutes = currentDate.getMinutes();
                        var seconds = currentDate.getSeconds();

                        var formattedTime = padZero(hours) + ":" + padZero(minutes) + ":" + padZero(seconds);
                        timeLabel.text = formattedTime;
                        signal_label.text = device_status.mvGetSignalLevel();
                        battery_label.text = device_status.mvGetBatteryLevel();
                        wifi_label.text = device_status.mvGetWifiLevel();
                    }
                }

                Text{
                    id: timeLabel
                    text: ""
                    font.pixelSize: 12
                    color: "#ffffff"
                }
                Label{
                    id: signal_label
                    text: "signal"
                    font.pixelSize: 12
                    color: "#ffffff"
                }
                Label{
                    id: battery_label
                    text: "battery"
                    font.pixelSize: 12
                    color: "#ffffff"
                }
                Label{
                    id: wifi_label
                    text: "wifi"
                    font.pixelSize: 12
                    color: "#ffffff"
                }
            }
        }
    }
    Pane{
        id: floating_subcontrol_mid
        visible: true
        height: 110
        Layout.fillWidth: true
        anchors.left: floating_subcontrol_left.right
        anchors.bottom: floating_subcontrol_left.bottom
        anchors.right: floating_subcontrol_right.left
        background: Rectangle{
            color: "transparent"
//            border.color: "#21be2b"
        }

        RowLayout{
            id: grid_right
            Layout.fillWidth: true
            Layout.fillHeight: true
            anchors.verticalCenter: parent.verticalCenter
            ColumnLayout{
                Rectangle{
                    radius: 5 // 设置圆角大小
                    color: "#553c3f41"
                    anchors.fill: parent
                }
                Layout.preferredWidth: 120
                Layout.preferredHeight: 110
                Layout.fillWidth: true
                Label{
                    Layout.alignment: Qt.AlignTop
                    text: "辐射率：1.00"
                    color: "#ffffff"
                    font.pixelSize: 12
                    leftPadding: 6
                    topPadding: 6
                    bottomPadding: 0
                }
                Label{
                    Layout.alignment: Qt.AlignTop
                    id: distance_label
                    text: "距离："
                    color: "#ffffff"
                    font.pixelSize: 12
                    leftPadding: 6
                    topPadding: 2
                    bottomPadding: 0
                }
                Label{
                    Layout.alignment: Qt.AlignTop
                    id: consentration_label
                    text: "浓度："
                    color: "#ffffff"
                    font.pixelSize: 12
                    leftPadding: 6
                    topPadding: 2
                    bottomPadding: 0
                }
                Label{
                    Layout.alignment: Qt.AlignTop
                    text: "环境湿度："
                    color: "#ffffff"
                    font.pixelSize: 12
                    leftPadding: 6
                    topPadding: 2
                    bottomPadding: 0
                }
                Timer{
                    id: tdlas_timer
                    interval: 500
                    running: true
                    repeat: true

                    onTriggered:{
                        distance_label.text = "距离：" + tdlas_ctrl.mvGetValueByPropertyName("consentration") + "ppm";
                        consentration_label.text = "浓度：" + tdlas_ctrl.mvGetValueByPropertyName("distance") + "m";
                    }
                }
            }
            Item{
                width: 50
            }
            RowLayout{
                Button{
                    Layout.fillWidth: true
                    Layout.preferredWidth: 33
                    Layout.preferredHeight: 33
                    background: Rectangle{
                        radius: 15 // 设置圆角大小
                        color: parent.pressed ? "#881d262f" : "#00552623"
                        border.width: 1
                        anchors.fill: parent
                    }
                    onClicked:{
                        var component = Qt.createComponent("gas_enhance_dlg.qml");
                        var dialog = component.createObject(mainWindow);
                        dialog.open();
                    }
                    text: "增"
                }
                Button{
                    Layout.fillWidth: true
                    Layout.preferredWidth: 33
                    Layout.preferredHeight: 33
                    background: Rectangle{
                        radius: 15 // 设置圆角大小
                        color: parent.pressed ? "#881d262f" : "#00552623"
                        border.width: 1
                        anchors.fill: parent
                    }
                    onClicked:{
                        testbtn(123);
                    }
                    text: "曝"
                }
                Button{
                    Layout.fillWidth: true
                    Layout.preferredWidth: 33
                    Layout.preferredHeight: 33
                    background: Rectangle{
                        radius: 15 // 设置圆角大小
                        color: parent.pressed ? "#881d262f" : "#00552623"
                        border.width: 1
                        anchors.fill: parent
                    }
                    onClicked:{
                        testbtn(123);
                    }
                    text: "锁"
                }
                Button{
                    Layout.fillWidth: true
                    Layout.preferredWidth: 33
                    Layout.preferredHeight: 33
                    background: Rectangle{
                        radius: 15 // 设置圆角大小
                        color: parent.pressed ? "#881d262f" : "#00552623"
                        border.width: 1
                        anchors.fill: parent
                    }
                    onClicked:{
                        testbtn(123);
                    }
                    text: "激"
                }
                Button{
                    Layout.fillWidth: true
                    Layout.preferredWidth: 33
                    Layout.preferredHeight: 33
                    background: Rectangle{
                        radius: 15 // 设置圆角大小
                        color: parent.pressed ? "#881d262f" : "#00552623"
                        border.width: 1
                        anchors.fill: parent
                    }
                    onClicked:{
                        zoomin(123);
                    }
                    text: "+"
                }
                Button{
                    Layout.fillWidth: true
                    Layout.preferredWidth: 33
                    Layout.preferredHeight: 33
                    background: Rectangle{
                        radius: 15 // 设置圆角大小
                        color: parent.pressed ? "#881d262f" : "#00552623"
                        border.width: 1
                        anchors.fill: parent
                    }
                    onClicked:{
                        zoomout(123);
                    }
                    text: "-"
                }
            }
        }
    }
    Pane{
        id: floating_subcontrol_right
        visible: true
        width: 65
        height: parent.height
        anchors.right: parent.right
        anchors.margins: 0
        background: Rectangle{
            color: "#010101"
            //border.color: "#21be2b"
        }
        ColumnLayout{
            id: grid_pane_right
            //            Layout.fillWidth: true
            //            Layout.fillHeight: true
            anchors.margins: 0
            anchors.fill: parent
            Button{
                Layout.fillWidth: true
                Layout.preferredWidth: 33
                Layout.preferredHeight: 33
                background: Rectangle{
                    radius: 15 // 设置圆角大小
                    color: parent.pressed ? "#1d262f" : "#552623"
                    border.width: 1
                    anchors.fill: parent
                }
                onClicked:{
                    switchRenderMode(123);
                }
                text: "切"
            }
            Button{
                Layout.fillWidth: true
                //                Layout.preferredWidth: 65
                //                Layout.preferredHeight: 30
                Layout.margins: 0
                onPressed:{
                    canvas.circleColor = "#cacacb";
                    canvas.requestPaint();
                    snapshot();
                }
                onReleased:{
                    canvas.circleColor = "white"
                    canvas.requestPaint();
                }
                contentItem: Canvas{
                    id: canvas
                    property color circleColor: "white"
                    anchors.fill: parent
                    onPaint:{
                        var ctx = getContext("2d");
                        ctx.clearRect(0, 0, width, height);

                        var centerX = width / 2;
                        var centerY = height / 2;
                        var radius = Math.min(width, height) / 2;

                        var startAngle = 0; // 开始角度
                        var endAngle = 2 * Math.PI; // 结束角度

                        ctx.fillStyle = "#010101";
                        ctx.fillRect(0, 0, width, height);
                        // 外圆环
                        ctx.beginPath();
                        ctx.arc(centerX, centerY, radius - 2, startAngle, endAngle);
                        ctx.strokeStyle = circleColor;
                        ctx.lineWidth = 4;
                        ctx.stroke();
                        ctx.fillStyle = "rgba(255, 0, 0, 0.5)";
                        // 内圆
                        var innerRadius = radius - 6;
                        ctx.beginPath();
                        ctx.arc(centerX, centerY, innerRadius, startAngle, endAngle);
                        ctx.fillStyle = circleColor;
                        ctx.fill();
                    }
                }
            }
            Button{
                Layout.fillWidth: true
                Layout.preferredWidth: 47
                Layout.preferredHeight: 47
                onClicked:{
                    testbtn(123);
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"
                    Image{
                        anchors.fill: parent
                        source: "./images/record.png"
                    }
                }
            }
            Button{
                Layout.fillWidth: true
                Layout.preferredWidth: 47
                Layout.preferredHeight: 47
                onClicked:{
                    testbtn(123);
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "transparent"
                    Image{
                        anchors.fill: parent
                        source: "./images/playback.png"
                    }
                }
            }
        }
    }
}
