import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
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
            ListElement{type: "screenLevel"}
            ListElement{type: "screenLevelHigh"}
            ListElement{type: "screenLevelMid"}
            ListElement{type: "screenLevelLow"}
            ListElement{type: "distenceLevel"}
            ListElement{type: "miter"}
            ListElement{type: "inch"}
        }
        ExclusiveGroup { id: tabPositionGroup }
        ListView{
            model: pageModelsys_bat
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
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
                        }else if (model.type === "distenceLevel") {
                            return distenceLevel;
                        }else if (model.type === "miter") {
                            return miter;
                        }else if (model.type === "inch") {
                            return inch;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Item {
                width: ListView.view.width
                height: expanded ? 150 : 50
                property bool expanded: false  // Track the expanded/collapsed state
                Rectangle {
                    color: "#212126"
                    anchors.fill: parent
                }
                Column {
                    width: parent.width
                    spacing: 5

                    // Title row
                    Row {
                        width: parent.width
                        spacing: 10

                        Text {
                            text: model.title
                            font.pixelSize: 20
                            width: 0.8 * parent.width  // Adjust the width to your needs
                        }

                        MouseArea {
                            width: 0.2 * parent.width  // Adjust the width to your needs
                            height: 40
                            onClicked: expanded = !expanded
                            Rectangle {
                                width: parent.width
                                height: parent.height
                                color: "lightgray"
                                Text {
                                    anchors.centerIn: parent
                                    text: expanded ? "▼" : "►"
                                }
                            }
                        }
                    }

                    // Description row (collapsible)
                    Text {
                        text: model.description
                        font.pixelSize: 16
                        visible: expanded
                    }

                    // Detail row (collapsible)
                    Text {
                        text: model.detail
                        font.pixelSize: 14
                        visible: expanded
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
                            text: "温度单位设置"
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
                            text: "摄氏度 ℃"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 50
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            exclusiveGroup: tabPositionGroup
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
                            text: "华氏度 ℉"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 50
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            exclusiveGroup: tabPositionGroup
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
                            text: "开尔文 K"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 50
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            exclusiveGroup: tabPositionGroup
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
                id: distenceLevel
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "距离单位设置"
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
                id: miter
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "米 m"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 50
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            exclusiveGroup: tabPositionGroup
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
                id: inch
                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: "lightgreen"
                    border.color: "gray"
                    border.width: 1

                    RowLayout {
                        spacing: 10

                        Text {
                            text: "英尺 ft"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.leftMargin: 50
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        RadioButton {
                            exclusiveGroup: tabPositionGroup
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