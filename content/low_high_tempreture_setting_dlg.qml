import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
    width: 800
    height: 480
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent

        ListModel{
            id: pageModelsys_time
            ListElement{type: "highTempretureAlarm"}
            ListElement{type: "highTempretureNum"}
            ListElement{type: "lowTempretureAlarm"}
            ListElement{type: "lowTempretureNum"}
            ListElement{type: "autosnap"}
            ListElement{type: "autosnapInter"}
            ListElement{type: "autorecord"}
            ListElement{type: "audioalarm"}

        }

        ListView{
            model: pageModelsys_time
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "type1") {
                            //                        return delegate;
                        } else if (model.type === "highTempretureAlarm") {
                            return highTempretureAlarm;
                        } else if (model.type === "highTempretureNum") {
                            return highTempretureNum;
                        }else if (model.type === "lowTempretureAlarm") {
                            return lowTempretureAlarm;
                        }else if (model.type === "lowTempretureNum") {
                            return lowTempretureNum;
                        }else if (model.type === "autosnap") {
                            return autosnap;
                        }else if (model.type === "autosnapInter") {
                            return autosnapInter;
                        }else if (model.type === "autorecord") {
                            return autorecord;
                        }else if (model.type === "audioalarm") {
                            return audioalarm;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Component {
                id: highTempretureAlarm
                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1
                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            text: "高温报警"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        AppleStyleSwitch{
                            id: highTempretureSwitch
                            onToggled: {
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
            Component {
                id: highTempretureNum
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            text: "高温报警温度"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "40"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 50
                            color: "black"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "°C (-20-150)"
                            color: "white"
                        }
                    }
                }
            }
            Component {
                id: lowTempretureAlarm
                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1
                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            text: "低温报警"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        AppleStyleSwitch{
                            id: lowTempretureAlarmSwitch
                            onToggled: {
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
            Component {
                id: lowTempretureNum
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            text: "低温报警温度"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "40"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 50
                            color: "black"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "°C (-20-150)"
                            color: "white"
                        }
                    }
                }
            }
            Component {
                id: autosnap
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            text: "报警自动拍照"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        AppleStyleSwitch{
                            id: highTempretureSwitch
                            onToggled: {
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
            Component {
                id: autosnapInter
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            text: "时间间隔"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "10"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 50
                            color: "black"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "S (10-3600)"
                            color: "white"
                        }
                    }
                }
            }
            Component {
                id: autorecord
                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1
                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            text: "报警自动录视频"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        AppleStyleSwitch{
                            id: highTempretureSwitch
                            onToggled: {
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
            Component {
                id: audioalarm
                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1
                    RowLayout {
                        spacing: 10
                        Text {
                            Layout.leftMargin: 30
                            text: "报警语音提示"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        AppleStyleSwitch{
                            id: highTempretureSwitch
                            onToggled: {
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
        }
    }

}
