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
            id: pageModelsys_bat
            ListElement{type: "batShow"}
            ListElement{type: "screenLevel"}
            ListElement{type: "screenLevelHigh"}
            ListElement{type: "screenLevelMid"}
            ListElement{type: "screenLevelLow"}
        }

        ListView{
            model: pageModelsys_bat
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                onClicked: stackView.push(Qt.resolvedUrl(page))
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "batShow") {
                            return batShow;
                        } else if (model.type === "screenLevel") {
                            return screenLevel;
                        } else if (model.type === "screenLevelHigh") {
                            return screenLevelHigh;
                        } else if (model.type === "screenLevelMid") {
                            return screenLevelMid;
                        } else if (model.type === "screenLevelLow") {
                            return screenLevelLow;
                        } else {
                            return null;
                        }
                    }
                }
            }
            Component {
                id: batShow
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "电量图表展示"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
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
                id: screenLevel
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "屏幕亮度"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
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
                        spacing: 10

                        Text {
                            text: "高"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
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
                id: screenLevelMid
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "中"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
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
                        spacing: 10

                        Text {
                            text: "低"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 30
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