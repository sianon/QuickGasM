import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Window{
    id: dialog
    // modal: true
    width: 200
    height: 150
    // x: (parent.height - width) / 2
    // y: (parent.height - height) / 2
    x: 100
    y: 100
    // background:Rectangle {
    //     color: "#1e2129"
    // }

    ColumnLayout{
        anchors.centerIn: parent
        spacing: 5
        BeaverRadioBtn{
            id: myRadioBtn
            text: "Group 1, Option 1"
            width: 80
            height: 10
            onCheckedChanged:{
                if(checked){
                    console.log("Group 1, Option 1 selected");
                }
            }
        }
        BeaverRadioBtn{
            text: "Group 2, Option 1"
            width: 80
            height: 10
            onCheckedChanged:{
                if(checked){
                    console.log("Group 2, Option 1 selected");
                }
            }
        }
        BeaverRadioBtn{
            text: "Group 2, Option 2"
            width: 80
            height: 10
            onCheckedChanged:{
                if(checked){
                    console.log("Group 2, Option 2 selected");
                }
            }
        }
    }
}
