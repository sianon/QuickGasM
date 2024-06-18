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
            ListElement{type: "autosave"}
            ListElement{type: "autoupload"}
            ListElement{type: "autosnap"}
            ListElement{type: "autosnapInter"}
            ListElement{type: "autorecord"}
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
                        } else if (model.type === "autosave") {
                            return autosave;
                        }else if (model.type === "autoupload") {
                            return autoupload;
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

            Component{
                id: autosave
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
                            text: "手动拍照后自动保存"
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
                id: autoupload
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
                            text: "拍照照片自动上传到平台"
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
                            text: "定时拍照"
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
                            id: autoSnapInter
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
                id: autosnapTimes
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
                            text: "照片格式"
                            color: "white"
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 110
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Item {

                            width: 100
                        }
                        Label{
                            text: "JPG格式"
                            color: "white"
                        }
                    }
                }
            }
        }
    }

}
