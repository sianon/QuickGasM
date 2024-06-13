import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item{
    //    id: dialog
    //    modal: true
    width: 800
    height: 480
    //    padding: 0
    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }
    ColumnLayout{
        anchors.fill: parent

        ListModel{
            id: pageModelsys
            ListElement{type: "deviceInfo"}
            ListElement{type: "deviceType"}
            ListElement{type: "serialNum"}
            ListElement{type: "deviceVersion"}
            ListElement{type: "mainControlVersion"}
            ListElement{type: "algorithmVersion"}
            ListElement{type: "modelVersion"}
            ListElement{type: "softVersion"}
        }

        ListView{
            model: pageModelsys
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                onClicked: stackView.push(Qt.resolvedUrl(page))
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "deviceInfo") {
                            return deviceInfo;
                        } else if (model.type === "deviceType") {
                            return deviceType;
                        } else if (model.type === "serialNum") {
                            return serialNum;
                        } else if (model.type === "deviceVersion") {
                            return deviceVersion;
                        } else if (model.type === "mainControlVersion") {
                            return mainControlVersion;
                        } else if (model.type === "algorithmVersion") {
                            return algorithmVersion;
                        } else if (model.type === "modelVersion") {
                            return modelVersion;
                        } else if (model.type === "softVersion") {
                            return softVersion;
                        } else {
                            return null;
                        }
                    }
                }
            }
            Component {
                id: deviceInfo
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "设备名称"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
                        }
                        Item {width: 100}
                        Text {
                            text: "非制冷红外成像激光遥测气体泄漏检测仪"
                            color: "white"
                        }
                    }
                }
            }

            Component {
                id: deviceType
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "设备型号"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Text {
                            text: "R10非制冷红外成像激光遥测气体泄漏检测仪"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }

            Component {
                id: serialNum
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "序列号(SN)"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredHeight: 25
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                        }
                        Item {width: 100}
                        Text {
                            text: "2024080500001"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
            Component {
                id: deviceVersion
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "设备版本"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Text {
                            text: "2024080500001"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
            Component {
                id: mainControlVersion
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "主控版本"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Text {
                            text: "2024080500001"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
            Component {
                id: algorithmVersion
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "算法版本"
                            Layout.preferredHeight: 25
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Text {
                            text: "2024080500001"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
            Component {
                id: modelVersion
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            text: "算法模型"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Text {
                            text: "2024080500001"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
            Component {
                id: softVersion
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            text: "系统软件版本"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.leftMargin: 30
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Text {
                            text: "2024080500001"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
        }
    }
}