import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Local 1.0

Dialog{
    visible: true
    width: 800
    height: 36
    padding: 0
    x: 0
    y: 370
    background: Rectangle{
        color: "#333333"
    }
    RowLayout{
        spacing: 80
        Component.onCompleted:{
            var siblings = children;
            var siz = siblings.length;

            for(var i = 0; i < siz; i++){
                if(siblings[i] instanceof CheckBox){
                    siblings[i].enabled = gas_switch.checked;
                }
            }
        }
        AppleStyleSwitch {
            id: gas_switch
            text: ""
            Layout.leftMargin: 30
            Layout.preferredHeight: 25
            onClicked: {
                var siblings = parent.children;
                var siz = siblings.length;
                providers.mvSwitchGasMode(checked);
                for(var i = 0; i < siz; i++){
                    if(siblings[i] !== parent && siblings[i] instanceof CheckBox){
                        siblings[i].enabled = checked;
                    }
                }
            }
        }
        CheckBox{
            id: gas_probe
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36

            indicator:Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"
                Image{
                    anchors.fill: parent
                    source: "../images/gas_probe.png"
                }
            }
            onClicked:{
                console.log(checked);
                gas_probe.checked ? providers.mvSwitchGasDectect("on") : providers.mvSwitchGasDectect("off");
            }
        }
        CheckBox{
            id: gas_detect
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.margins: 0
            indicator:Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"
                Image{
                    anchors.fill: parent
                    source: "../images/gas_detect.png"
                }
            }
            onClicked:{
                gas_detect.checked ? providers.mvSwitchGasSplit("on") : providers.mvSwitchGasSplit("off");
            }
        }

        CheckBox{
            id: distribution
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.margins: 0
            indicator:Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"
                Image{
                    anchors.fill: parent
                    source: "../images/distribution.png"
                }
            }
            onClicked:{
                distribution.checked ? providers.mvSwitchConcentrationDistri("on") : providers.mvSwitchConcentrationDistri("off");
            }
        }
        CheckBox{
            id: plume_enhance
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked:{
                plume_enhance.checked ? providers.mvSwitchCloudGasEnhance("on") : providers.mvSwitchCloudGasEnhance("off");
            }
            indicator:Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"
                Image{
                    anchors.fill: parent
                    source: "../images/plume_enhance.png"
                }
            }
        }
        CheckBox{
            id: tdlas
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            onClicked:{
                tdlas.checked ? providers.mvSwitchDisplayTDLAS("on") : providers.mvSwitchDisplayTDLAS("off");
            }
            indicator:Rectangle{
                implicitHeight: parent.height
                implicitWidth: parent.height
                color: parent.enabled ? "#333333" : "#444444"
                Image{
                    anchors.fill: parent
                    source: "../images/concentration.png"
                }
            }
        }
    }
}