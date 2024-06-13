import QtQuick 2.2
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
            ListElement{type: "type2"}
            ListElement{type: "ntp_server"}
            ListElement{type: "syncRound"}
            ListElement{title: "手动校时"}
            ListElement{type: "manualInput"}

        }

        ListView{
            model: pageModelsys_time
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                onClicked: stackView.push(Qt.resolvedUrl(page))
                Loader {
                    width: parent.width
//                    height: parent.height
                    sourceComponent: {
                        if (model.type === "type1") {
                            //                        return delegate;
                        } else if (model.type === "type2") {
                            return type2Component;
                        } else if (model.type === "ntp_server") {
                            return ntpServer;
                        }else if (model.type === "syncRound") {
                            return syncRound;
                        }else if (model.type === "manualInput") {
                            return manualInput;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Component {
                id: type2Component
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
                            text: "NTP自动校时"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        Button {
                            text: "开关"
                            Layout.preferredHeight: 25
                            onClicked: {

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
                            text: "NTP服务器"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "ntp.aliyun.com"
                            Layout.preferredHeight: 25
                            color: "black"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "(支持域名或地址)"
                            color: "white"
                        }
                    }
                }
            }

            Component {
                id: syncRound
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
                            text: "同步周期"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "10"
                            color: "black"
                            Layout.preferredHeight: 25
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "分钟 (范围1-1440分钟)"
                            color: "white"
                        }
                    }
                }
            }
            Component {
                id: manualInput
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
                            text: "手动设置时间"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        TextField {
                            text: "10"
                            Layout.preferredHeight: 25
                            color: "black"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
        }
    }

}
