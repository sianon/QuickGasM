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

    function showMediaWind(){
        providers.mvRefeshFileList("");
        var component = Qt.createComponent("img_grid_dlg.qml");
        var dialog = component.createObject(mainWindow);
        dialog.open();
        console.log("qml showMediaWind runing", "return ok");
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
        color: "#000000"
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
                //TODO:视频刷新函数调用处
                providers.test();
            }
        }
    }
    Frame{
        id: floating_subcontrol_left
        visible: true
        width: 800
        height: 30
        padding: 0
        background: Rectangle{
            color: "#56282828"
        }
        RowLayout{
            anchors.fill: parent
            RowLayout{
                anchors.left: parent.left
                anchors.leftMargin: 10
                Label{
                    text: "中心温度："
                    font.pixelSize: 18
                    color: "#ffffff"
                }
                Text{
                    id: tempLabel
                    text: "25.1C"
                    font.pixelSize: 18
                    color: "#ffffff"
                }
            }
            RowLayout{
                anchors.right: parent.right
                anchors.rightMargin: 10
                Timer{
                    id: timer
                    //TODO:定时器刷新时间信号等数据
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: updateTime()

                    function padZero(value){
                        return (value < 10) ? "0" + value : value;
                    }

                    function updateTime(){
                        var currentDate = new Date();
                        var date = currentDate.toDateString();
                        var hours = currentDate.getHours();
                        var minutes = currentDate.getMinutes();
                        var seconds = currentDate.getSeconds();

                        var formattedTime =date + "  " + padZero(hours) + ":" + padZero(minutes) + ":" + padZero(seconds);
                        timeLabel.text = formattedTime;
                        //                        signal_label.text = device_status.mvGetSignalLevel();
                        var bat_lel = device_status.mvGetBatteryLevel();
                        if(bat_lel <= 25){
                            battery_label.source = "images/battery_1.png";
                        }else if(bat_lel > 25 && bat_lel <= 50){
                            battery_label.source = "images/battery_2.png";
                        }else if(bat_lel > 50 && bat_lel <= 75){
                            battery_label.source = "images/battery_3.png";
                        }else if(bat_lel > 75 && bat_lel <= 100){
                            battery_label.source = "images/battery_f.png";
                        }
                        //                        wifi_label.text = device_status.mvGetWifiLevel();
                    }
                }

                Text{
                    id: timeLabel
                    text: ""
                    font.pixelSize: 18
                    color: "#ffffff"
                }
                Item{
                    width: 10
                    height: 10
                }
                Image{
                    id: gps_label
                    sourceSize.height: 28
                    sourceSize.width: 28
                    source: "images/gps.png"
                }
                Item{
                    width: 8
                    height: 8
                }
                Image{
                    id: bluetooth_label
                    sourceSize.height: 28
                    sourceSize.width: 28
                    source: "images/bluetooth.png"
                }
                Item{
                    width: 8
                    height: 8
                }
                Image{
                    id: wifi_label
                    sourceSize.height: 28
                    sourceSize.width: 28
                    source: "images/WIFI.png"
                }
                Item{
                    width: 8
                    height: 8
                }
                Image{
                    id: signal_label
                    sourceSize.height: 28
                    sourceSize.width: 28
                    source: "images/signal_4.png"
                }
                Item{
                    width: 8
                    height: 8
                }
                Image{
                    id: battery_label
                    Layout.alignment: Qt.AlignRight
                    sourceSize.height: 28
                    sourceSize.width: 28
                    source: "images/battery_f.png"
                }
            }
        }
    }
    Pane{
        id: floating_subcontrol_mid
        visible: false
        height: 360
        width: parent.width
        anchors.left: parent.left
        anchors.top: floating_subcontrol_left.bottom
        background: Rectangle{
            color: "green"
        }
        RowLayout{
            id: grid_right
            width: parent.width
            height: parent.height
            ColumnLayout{
                Layout.alignment: Qt.AlignTop
                Item{
                    width: 10
                    height: 100
                }
                ColumnLayout{
                    visible: true
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 118
                    Rectangle{
                        radius: 5
                        color: "#553c3f41"
                        anchors.fill: parent
                    }
                    Label{
                        Layout.alignment: Qt.AlignTop
                        //TODO:发射率显示
                        text: "发射率：1.00"
                        color: "#ffffff"
                        font.pixelSize: 12
                        leftPadding: 6
                        topPadding: 6
                        bottomPadding: 0
                    }
                    Label{
                        Layout.alignment: Qt.AlignTop
                        id: distance_label
                        //TODO:测量距离显示
                        text: "测量距离："
                        color: "#ffffff"
                        font.pixelSize: 12
                        leftPadding: 6
                        topPadding: 2
                        bottomPadding: 0
                    }
                    Label{
                        Layout.alignment: Qt.AlignTop
                        id: consentration_label
                        //TODO:环境湿度显示
                        text: "环境湿度："
                        color: "#ffffff"
                        font.pixelSize: 12
                        leftPadding: 6
                        topPadding: 2
                        bottomPadding: 0
                    }
                    Label{
                        Layout.alignment: Qt.AlignTop
                        //TODO:环境温度显示
                        text: "环境温度："
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
                            //                        distance_label.text = distance_label.text + tdlas_ctrl.mvGetValueByPropertyName("consentration") + "ppm";
                            //                        consentration_label.text = consentration_label.text + tdlas_ctrl.mvGetValueByPropertyName("distance") + "m";
                        }
                    }
                }
                Label{
                    id: scal_label
                    text: "x1"
                    font.pixelSize: 18
                    font.weight: Font.Bold
                    color: "yellow"
                    //TODO:显示放大倍率
                }
            }
            ColumnLayout{
                visible: true
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                spacing: 0
                width: 120
                height: parent.height
                Button{
                    Layout.preferredWidth: 46
                    Layout.preferredHeight: 46
                    Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Image {
                        sourceSize.height: parent.height
                        sourceSize.width: parent.width
                        source: "images/flap.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    onClicked:{
                        //TODO:校准挡板按钮
                        console.log("flap");
                    }
                }
                Label{
                    id: upper_boundary
                    //TODO:归一化上边界
                    Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 22
                    text: "35.6C"
                    color: "black"
                    font.pixelSize: 12
                    padding: 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    background: Rectangle {
                        color: "#f2f2f2"
                    }
                }
                Rectangle{
                    Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
                    id: distance_labels
                    height: 230
                    width: 30
                    color: "#ec5306"
                }
                Label{
                    id: lower_boundary
                    //TODO:归一化下边界
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 22
                    Layout.alignment: Qt.AlignTop|Qt.AlignHCenter
                    text: "31.6C"
                    color: "black"
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    background: Rectangle {
                        color: "#f2f2f2"
                    }
                }
            }
        }
    }
    Pane{
        id: floating_subcontrol_right
        visible: true
        width: 800
        height: 42
        anchors.bottom: parent.bottom
        anchors.margins: 0
        padding: 0
        background: Rectangle{
            color: "#333333"
        }
        RowLayout{
            id: grid_pane_right
            anchors.leftMargin: 60
            anchors.fill: parent
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
                        source: "./images/tempmeasure.png"
                    }
                }
                onClicked:{
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
                        source: "./images/gasprobe.png"
                    }
                }
                onClicked:{
                    switchRenderMode(123);
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
                        source: "./images/envTemp.png"
                    }
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    testbtn(123);
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "./images/mode.png"
                    }
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    var component = Qt.createComponent("color_setting_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "./images/colormap.png"
                    }
                }
            }
            Button{
                //                Layout.fillWidth: true
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    showMediaWind();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "./images/media.png"
                    }
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    var component = Qt.createComponent("advance_sys_setting_dlg.qml");
                    var dialog = component.createObject(mainWindow);
                    dialog.open();
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "./images/settings.png"
                    }
                }
            }
        }
    }
}
