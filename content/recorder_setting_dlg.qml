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
            ListElement{type: "mannulRecAutoSave"}
            ListElement{type: "videoFormat"}

        }

        ListView{
            model: pageSnapShot
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "mannulRecAutoSave") {
                            return mannulRecAutoSave;
                        } else if (model.type === "videoFormat") {
                            return videoFormat;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Component{
                id: mannulRecAutoSave
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
                id: videoFormat
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
