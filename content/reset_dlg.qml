
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
            id: pageModelsys_reset
            ListElement{type: "reset"}
        }

        ListView{
            model: pageModelsys_reset
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                onClicked: stackView.push(Qt.resolvedUrl(page))
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "reset") {
                            return reset;
                        } else {
                            return null;
                        }
                    }
                }
            }
            Component {
                id: reset
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10
                        Text {
                            text: "恢复出产设置"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        Button {
                            Layout.preferredHeight: 25
                            text: "恢复出产设置"
                        }
                    }
                }
            }

            Component {
                id: sysVersion
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Text {
                            text: "当前系统版本号"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: "V01.20240805"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }

            Component {
                id: screenLevelHigh
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Text {
                            text: "选择升级文件"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        TextField {
                            text: "点击选择升级文件"
                            color: "black"

                        }
                        Button {
                            text: "开始升级"
                            onCheckedChanged: {
                                if (checked) {
                                    console.log("Group 1, Option 2 selected");
                                }
                            }
                        }
                    }
                }
            }
            Component {
                id: screenLevelMid
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Text {
                            text: "中"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            text: "Group 1, Option 2"
                            onCheckedChanged: {
                                if (checked) {
                                    console.log("Group 1, Option 2 selected");
                                }
                            }
                        }
                    }
                }
            }
            Component {
                id: screenLevelLow
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Text {
                            text: "低"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            text: "Group 1, Option 2"
                            onCheckedChanged: {
                                if (checked) {
                                    console.log("Group 1, Option 2 selected");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}