import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
//    modal: true
    width: 300
    height: 80
    padding: 0
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    background: Rectangle{
        color: "#333333"
    }

    function colorTempletChange(val_arg){
        providers.mvSetColorType(val_arg);
        console.log("colorTempletChange", val_arg, "return ok");
        return "ok";
    }

    GridLayout {
        anchors.fill: parent
        columns: 5
        rowSpacing: 0
        columnSpacing: 0
        width: dialog.width
        height: dialog.height
        ColorBtn {
            text: "白热"
            onClicked: {
                colorTempletChange("color_type_black_white");
            }
        }
        ColorBtn {
            text: "黑热"
        }
        ColorBtn{
            text: "铁红"
            onClicked: {
                colorTempletChange("color_type_iron_red");
            }
        }
        ColorBtn {
            text: "花青"
        }
        ColorBtn {
            text: "彩虹"
            onClicked: {
                colorTempletChange("color_type_rainbow");
            }
        }
        ColorBtn {
            text: "反彩虹"
        }
        ColorBtn {
            text: "红棕"
            onClicked: {
                colorTempletChange("color_type_red");
            }
        }

        ColorBtn {
            text: "热铁"
        }

        ColorBtn {
            text: "冷色"
        }
        ColorBtn {
            text: "火灾"
            onClicked: {
                colorTempletChange();
            }
        }
    }
}
