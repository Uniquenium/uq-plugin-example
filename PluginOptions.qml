import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Templates as T
import QtQuick.Controls.Basic
import UniDesk
import UniDesk.Controls
import UniDesk.Singletons

UniDeskWindow{
    id: window
    width: 1000
    height: 700
    title: qsTr("文本选项")
    autoVisible: false
    showMinimize: false
    showMaximize: false
    autoDestroy: false
    property var comManager
    property UniDeskComBase editingComponent
    ScrollView{
        anchors.fill: parent
        hoverEnabled: true
        contentHeight: opacitySpinBox.y+opacitySpinBox.height-text0.y+30
        UniDeskText{
            id: text0
            text: qsTr("组件名称（不能重复）")
            font: UniDeskTextStyle.little
            anchors.left: parent.left
            anchors.margins: 10
            anchors.verticalCenter: idField.verticalCenter
        }
        UniDeskTextField {
            id: idField
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10
            placeholderText: qsTr("请输入组件名称")
            text: editingComponent ? editingComponent.name : ""
            onEditingFinished: {
                if(comManager.validateName(text)){  
                    if (editingComponent)   {
                        editingComponent.name = text;
                    }
                }
                else{
                    text = editingComponent.name;
                }
                editingComponent.saveComToFile();
            }
        }
        UniDeskText{
            text: qsTr("父组件")
            font: UniDeskTextStyle.little
            anchors.left: parent.left
            anchors.margins: 10
            anchors.verticalCenter: parentComboBox.verticalCenter
        }
        UniDeskComBox{
            id: parentComboBox
            anchors.top: idField.bottom
            anchors.right: parent.right
            anchors.margins: 10
            comManager: window.comManager
            editingComponent: window.editingComponent
            currentComponent: window.editingComponent.parent
            onActivated: {
                let p = parentComboBox.getComByIndex(currentIndex);
                editingComponent.changeParentWithoutMoving(p);
                editingComponent.saveComToFile();
            }
        }
        UniDeskPosSelector{
            id: posSelector
            comManager: window.comManager
            anchors.top: parentComboBox.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            editingComponent: window.editingComponent
        }
        UniDeskSizeSelector{
            id: sizeSelector
            anchors.top: posSelector.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            editingComponent: window.editingComponent
        }
        UniDeskText{
            id: text13
            text: qsTr("旋转角度")
            font: UniDeskTextStyle.little
            anchors.left: parent.left
            anchors.verticalCenter: rotationSpinBox.verticalCenter
            anchors.margins: 10
        }
        UniDeskSpinBox{
            id: rotationSpinBox
            anchors.top: sizeSelector.bottom
            anchors.right: parent.right
            anchors.margins: 10
            editable: true
            value: editingComponent ? editingComponent.rotation : 0
            from: 0
            to: 359
            stepSize: 1
            onValueModified: {
                if (editingComponent) {
                    editingComponent.rotation = value;
                    editingComponent.saveComToFile();
                }
            }
        }
        UniDeskText{
            id: textOpacity
            text: qsTr("透明度")
            font: UniDeskTextStyle.little
            anchors.left: parent.left
            anchors.margins: 10
            anchors.verticalCenter: opacitySpinBox.verticalCenter
        }
        UniDeskSpinBox{
            id: opacitySpinBox
            anchors.top: rotationSpinBox.bottom
            anchors.right: parent.right
            anchors.margins: 10
            editable: true
            value: editingComponent ? editingComponent.itemOpacity * 100 : 100
            from: 0
            to: 100
            stepSize: 1
            onValueModified: {
                if (editingComponent) {
                    editingComponent.itemOpacity = value / 100;
                    editingComponent.saveComToFile();
                }
            }
        }
    }
    Connections{
        target: UniDeskGlobals
        function onApplicationQuit() {
            window.close();
        }
    }
    Component.onCompleted: {
        posSelector.refreshPosition();
    }
}
