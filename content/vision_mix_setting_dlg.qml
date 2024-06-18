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
            ListElement{type: "autoTrack"}
            ListElement{type: "mannulTrack"}
        }

        ListView{
            model: pageSnapShot
            anchors.fill: parent
            delegate: AndroidDelegate{
                text: title
                Loader {
                    width: parent.width
                    sourceComponent: {
                        if (model.type === "autoTrack") {
                            return autoTrack;
                        } else if (model.type === "mannulTrack") {
                            return mannulTrack;
                        } else {
                            return null;
                        }
                    }
                }
            }

            Component{
                id: autoTrack
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
                            text: "画中画自动追踪"
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
                id: mannulTrack
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
                            text: "画中画手动调整"
                            color: "white"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {width: 100}
                        AppleStyleSwitch{
                            id: highTempretureSwitch
                            onToggled:{
                                console.log("Switch toggled, checked: " + checked)
                            }
                        }
                    }
                }
            }
        }
    }
}
