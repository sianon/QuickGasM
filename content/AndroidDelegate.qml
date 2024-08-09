import QtQuick 2.2

Item {
    id: root
    width: 800
    height: 40

    property alias text: textitem.text
    signal clicked

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        height: 38
        color: "#555555"
//        visible: mouse.pressed
    }
    Rectangle {
        anchors.fill: parent
        color: "#11ffffff"
        visible: mouse.pressed
    }
    Image {
        id: image
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: 28
        sourceSize.width: 28
        Component.onCompleted:{
            if(text == "系统设置"){
                image.source = "../images/settings.png"
            }else if(text == "报警管理"){
                image.source = "../images/alarm_settings.png"
            }else if(text == "拍照设置"){
                image.source = "../images/snapshot_settings.png"
            }else if(text == "云服务"){
                image.source = "../images/cloud_settings.png"
            }else if(text == "网络设置"){
                image.source = "../images/net_settings.png"
            }else if(text == "双光设置"){
                image.source = "../images/vision_mix_settings.png"
            }else if(text == "测量单位设置"){
                image.source = "../images/measurement_settings.png"
            }else if(text == "录像设置"){
                image.source = "../images/record_settings.png"
            }else if(text == "气体泄漏报警设置"){
                image.source = "../images/gas_leak_settings.png"
            }else if(text == "高低温报警设置"){
                image.source = "../images/low_high_tempreture_settings.png"
            }else if(text == "报警记录"){
                image.source = "../images/alarm_log_settings.png"
            }
            var path = image.source.toString();
            if(path.length > 0){
                next.source = "../images/navigation_next_item.png";
            }else{
                next.source = "";
            }
        }
    }
    Text {
        id: textitem
        color: "white"
        font.pixelSize: 16
        text: modelData
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 80
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.margins: 0
        height: 2
        color: "#333333"
    }

    Image {
        id: next
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: 28
        sourceSize.width: 28
//        source: "../images/navigation_next_item.png"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()

    }
}
