import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog{
    id: dialog
    width: 300
    height: 80
    padding: 0
    x: 388
    y: 330
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
            onClicked: {
                colorTempletChange("color_type_black_hot");
            }
        }
        ColorBtn{
            text: "铁红"
            onClicked: {
                colorTempletChange("color_type_iron_red");
            }
        }
        ColorBtn {
            text: "花青"
            onClicked: {
                colorTempletChange("color_type_green");
            }
        }
        ColorBtn {
            text: "彩虹"
            onClicked: {
                colorTempletChange("color_type_rainbow");
            }
        }
        ColorBtn {
            text: "反彩虹"
            onClicked: {
                colorTempletChange("color_type_rainbow_reverse");
            }
        }
        ColorBtn {
            text: "红棕"
            onClicked: {
                colorTempletChange("color_type_red_brown");
            }
        }

        ColorBtn {
            text: "热铁"
            onClicked: {
                colorTempletChange("color_type_red");
            }
        }

        ColorBtn {
            text: "冷色"
            onClicked: {
                colorTempletChange("color_type_cold");
            }
        }
        ColorBtn {
            text: "火灾"
            onClicked: {
                colorTempletChange();
            }
        }
    }
}
