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
            id: pageSnapShot
            ListElement{type: "type2"}
            ListElement{type: "audioalarm"}

        }

        ListView{
            model: pageSnapShot
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "type1") {
                            //                        return delegate;
                        } else if (model.type === "type2") {
                            return type2Component;
                        } else if (model.type === "audioalarm") {
                            return audioalarm;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Component{
                id: type2Component
                Rectangle {
                    width: parent.width
                    height: parent.height
                    anchors.fill: parent
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout{
                        spacing: 10
                        Text{
                            Layout.leftMargin: 30
                            text: "手动录像后自动保存"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item{
                            width: 100
                        }
                        AppleStyleSwitch{
                            id: highTempretureSwitch
                            onToggled:{
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
            Component {
                id: ntpServer
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
                            text: "拍摄张数"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "10"
                            id: autoSnapNum
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 50
                            color: "black"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "张 (5-1000)"
                            color: "white"
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
                            text: "视频格式"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        Label{
                            text: "mp4格式"
                            color: "white"
                        }
                    }
                }
            }
        }
    }

}
