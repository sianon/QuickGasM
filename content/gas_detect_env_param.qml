
import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Dialog{
    id: gas_detect_env_param
    visible: true
    width: 800
    height: 196
    padding: 0
    x: 0
    y: 190
    background: Rectangle{
        color: "transparent"
    }
    ColumnLayout{
        spacing: 0
        RowLayout{
            spacing: 10
            Layout.preferredWidth: 800
            Layout.preferredHeight: 180
            RowLayout{
                id: slider_layout
                visible: false
                Layout.leftMargin: 30
                spacing: 0
                ListModel {
                    id: fruitModel
                    ListElement { name: "抛光铝或者铝箔"; rate: "0.09"}
                    ListElement { name: "轻度氧化铝"; rate: "0.15" }
                    ListElement { name: "塑料(PVC)"; rate: "0.94" }
                    ListElement { name: "抛光铝或者铝箔"; rate: "0.09"}
                    ListElement { name: "轻度氧化铝"; rate: "0.15" }
                    ListElement { name: "塑料(PVC)"; rate: "0.94" }
                }
                ListModel {
                    id: rateModel
                    Component.onCompleted: {
                        for (var i = 1; i <= 100; i++) {
                            var rate = (i*0.01).toFixed(2);
                            rateModel.append({name: rate});
                        }
                    }
                }
                Column {
                    Rectangle {
                        width: 60
                        height: 35
                        color: "lightblue"
                        Text {
                            anchors.centerIn: parent
                            text: "直接选择\n发射率"
                            font.pixelSize: 9
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                        }
                    }
                    ListView {
                        id: ratelist
                        width: 60
                        height: 120
                        model: rateModel
                        clip: true
                        delegate: Item {
                            width: 60
                            height: 20
                            Rectangle {
                                width: 60
                                height: 20
                                color: ratelist.currentIndex === index ? "darkgray" : "#414141"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        ratelist.currentIndex = index;
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: model.name
                                    font.pixelSize: 10
                                    color: "white"
                                }
                            }
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex !== -1) {
                                providers.mvSetEmissivity(rateModel.get(currentIndex).name);
                            }
                        }
                    }
                }
                Column {
                    width: 200
                    Rectangle {
                        width: parent.width
                        height: 35
                        color: "lightblue"
                        Text {
                            anchors.centerIn: parent
                            text: "根据被测材料选择发射率"
                            font.pixelSize: 9
                            Layout.alignment: Qt.AlignHCenter
                            color: "white"
                        }
                    }

                    ListView {
                        id: listView2
                        width: parent.width
                        height: 120
                        model: fruitModel
                        clip: true
                        delegate: Item {
                            width: parent.width
                            height: 20
                            Rectangle {
                                width: parent.width
                                height: 20
                                color: listView2.currentIndex === index ? "darkgray" : "#333333"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        listView2.currentIndex = index;
                                    }
                                }
                                Text {
                                    text: model.name
                                    font.pixelSize: 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    width: 150
                                    color: "white"
                                }
                                Text {
                                    width: 50
                                    text: model.rate
                                    font.pixelSize: 16
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "white"
                                }
                            }
                        }
                        onCurrentIndexChanged: {
                            if (currentIndex !== -1) {
                                providers.mvSetEmissivity(fruitModel.get(currentIndex).name);
                            }
                        }
                    }
                }
            }
            RowLayout{
                id: temp_layout
                visible: false
                Layout.leftMargin: 120
                Text{
                    text: "-10℃"
                    color: "#bdbebf"
                }
                Slider{
                    id: temp
                    from: -10
                    to: 50
                    background: Rectangle{
                        x: temp.leftPadding
                        y: temp.topPadding + temp.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: temp.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#bdbebf"

                        Rectangle{
                            width: temp.visualPosition * parent.width
                            height: parent.height
                            color: "#007aff"
                            radius: 2
                        }
                    }
                    handle: Rectangle{
                        x: temp.leftPadding + temp.visualPosition * (temp.availableWidth - width)
                        y: temp.topPadding + temp.availableHeight / 2 - height / 2
                        implicitWidth: 42
                        implicitHeight: 26
                        radius: 13
                        color: temp.pressed ? "#f0f0f0" : "#f6f6f6"
                        border.color: "#bdbebf"
                        Text{
                            anchors.centerIn: parent
                            text: temp.value.toFixed(0)+"℃"
                        }
                    }
                }
                Text{
                    text: "+50℃"
                    color: "#bdbebf"
                }
                Button{
                    text: "确认"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle{
                        implicitWidth: 80
                        implicitHeight: 40
                        radius: 20
                        color: parent.pressed ? "#ffffff" : "#81d3f8"
                    }
                    onClicked:{
                        temp_layout.visible = false;
                        providers.mvSetEnvTemp(temp.value.toFixed(0));
                    }
                }
                Button{
                    text: "取消"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle{
                        implicitWidth: 80
                        implicitHeight: 40
                        radius: 20
                        color: "#ffffff"
                    }
                    onClicked:{
                        temp_layout.visible = false;
                    }
                }
                Item{
                    Layout.fillWidth: true
                }
            }
            RowLayout{
                id: humidity_layout
                visible: false
                Layout.leftMargin: 120
                Text{
                    text: "10%"
                    color: "#bdbebf"
                }
                Slider{
                    id: humidity
                    from: 10
                    to: 95

                    background: Rectangle{
                        x: humidity.leftPadding
                        y: humidity.topPadding + humidity.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: humidity.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#bdbebf"

                        Rectangle{
                            width: humidity.visualPosition * parent.width
                            height: parent.height
                            color: "#007aff"
                            radius: 2
                        }
                    }

                    handle: Rectangle{
                        x: humidity.leftPadding + humidity.visualPosition * (humidity.availableWidth - width)
                        y: humidity.topPadding + humidity.availableHeight / 2 - height / 2
                        implicitWidth: 32
                        implicitHeight: 26
                        radius: 13
                        color: humidity.pressed ? "#f0f0f0" : "#f6f6f6"
                        border.color: "#bdbebf"
                        Text{
                            anchors.centerIn: parent
                            text: humidity.value.toFixed(0)+"%"
                        }
                    }
                }
                Text{
                    text: "90%"
                    color: "#bdbebf"
                }
                Button{
                    text: "确认"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle{
                        implicitWidth: 80
                        implicitHeight: 40
                        radius: 20
                        color: parent.pressed ? "#ffffff" : "#81d3f8"
                    }
                    onClicked:{
                        humidity_layout.visible = false;
                        providers.mvSetEnvhumidity(humidity.value.toFixed(0));
                    }
                }
                Button{
                    text: "取消"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle{
                        implicitWidth: 80
                        implicitHeight: 40
                        radius: 20
                        color: "#ffffff"
                    }
                    onClicked:{
                        humidity_layout.visible = false;
                    }
                }
                Item{
                    Layout.fillWidth: true
                }
            }
            RowLayout{
                id: distance_layout
                Layout.leftMargin: 120
                visible: false
                Text{
                    text: "1m"
                    color: "#bdbebf"
                }
                Slider{
                    id: distance
                    from: 1
                    to: 20

                    background: Rectangle{
                        x: distance.leftPadding
                        y: distance.topPadding + distance.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: distance.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#bdbebf"

                        Rectangle{
                            width: distance.visualPosition * parent.width
                            height: parent.height
                            color: "#007aff"
                            radius: 2
                        }
                    }

                    handle: Rectangle{
                        x: distance.leftPadding + distance.visualPosition * (distance.availableWidth - width)
                        y: distance.topPadding + distance.availableHeight / 2 - height / 2
                        implicitWidth: 50
                        implicitHeight: 26
                        radius: 13
                        color: distance.pressed ? "#f0f0f0" : "#f6f6f6"
                        border.color: "#bdbebf"
                        Text{
                            anchors.centerIn: parent
                            text: distance.value.toFixed(1)+"m"
                        }
                    }
                }
                Text{
                    text: "20m"
                    color: "#bdbebf"
                }
                Button{
                    text: "确认"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle{
                        implicitWidth: 80
                        implicitHeight: 40
                        radius: 20
                        color: parent.pressed ? "#ffffff" : "#81d3f8"
                    }
                    onClicked:{
                        distance_layout.visible = false;
                        providers.mvSetDistance(distance.value.toFixed(1));
                    }
                }
                Button{
                    text: "取消"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 80
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle{
                        implicitWidth: 80
                        implicitHeight: 40
                        radius: 20
                        color: "#ffffff"
                    }
                    onClicked:{
                        distance_layout.visible = false;
                    }
                }
                Item{
                    Layout.fillWidth: true
                }
            }

        }
        RowLayout{
            spacing: 60
            Rectangle{
                color: "#333333"
                anchors.fill: parent
            }
            CheckBox{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.leftMargin: 60
                indicator:Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "../images/emissivity.png"
                    }
                }
                onClicked:{
                    slider_layout.visible = !slider_layout.visible;
                    humidity_layout.visible = false;
                    distance_layout.visible = false;
                    temp_layout.visible = false;
                }
            }
            CheckBox{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.margins: 0
                indicator:Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "../images/env_tmp.png"
                    }
                }
                onClicked:{
                    temp_layout.visible = !temp_layout.visible;
                    humidity_layout.visible = false;
                    distance_layout.visible = false;
                    slider_layout.visible = false;
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
                        source: "../images/env_tmp_auto.png"
                    }
                }
                onClicked:{
                    temp_layout.visible = false;
                    humidity_layout.visible = false;
                    distance_layout.visible = false;
                    slider_layout.visible = false;
                    providers.mvSetEnvTemp("auto");
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    humidity_layout.visible = !humidity_layout.visible;
                    temp_layout.visible = false;
                    distance_layout.visible = false;
                    slider_layout.visible = false;
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "../images/env_humidity.png"
                    }
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    temp_layout.visible = false;
                    humidity_layout.visible = false;
                    distance_layout.visible = false;
                    slider_layout.visible = false;
                    providers.mvSetEnvhumidity("auto");
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "../images/env_humidity_auto.png"
                    }
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    distance_layout.visible = !distance_layout.visible;
                    humidity_layout.visible = false;
                    temp_layout.visible = false;
                    slider_layout.visible = false;
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "../images/distance.png"
                    }
                }
            }
            Button{
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                onClicked:{
                    temp_layout.visible = false;
                    humidity_layout.visible = false;
                    distance_layout.visible = false;
                    slider_layout.visible = false;
                    providers.mvSetDistance("auto");
                }
                Rectangle{
                    implicitHeight: parent.height
                    implicitWidth: parent.height
                    color: "#333333"
                    Image{
                        anchors.fill: parent
                        source: "../images/distance_auto.png"
                    }
                }
            }
            Item{
                Layout.fillWidth: true
            }
        }
    }
}
