import QtQuick
import QtQuick.Controls
import UniDesk
import UniDesk.Controls
// import org.uq.pluginexample 1.0

UniDeskComBase{
    id: base
    visible: true
    type: "Uniquenium.PluginExample"
    width: 300
    height: 300
    chosen: options ? options.visible : false
    Rectangle {
        id: cont
        width: base.width
        height: base.height
        color: "#f0f0f0"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                text: "Plugin Component"
                font.bold: true
                font.pixelSize: 20
                color: "#333"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Backend {
                id: backend
            }

            Text {
                text: "Message: " + backend.message
                font.pixelSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Counter: " + backend.counter
                font.pixelSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Say Hello"
                onClicked: {
                    console.log(backend.sayHello("QML"))
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Increment"
                onClicked: {
                    backend.incrementCounter()
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Add 5+3"
                onClicked: {
                    console.log("Result: " + backend.addNumbers(5, 3))
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
    UniDeskMenu{
        id: menu
        UniDeskMenuItem{
            text: qsTr("编辑")
            iconSource: "qrc:/media/img/edit.svg"
            onClicked: {
                options.show()
            }
        }
        UniDeskMenuItem{
            text: qsTr("复制")
            iconSource: "qrc:/media/img/copy.svg"
            onClicked: {
                base.copyCom();
            }
        }
        UniDeskMenuItem{
            text: qsTr("新建子组件")
            iconSource: "qrc:/media/img/add-line.svg"
            onClicked: {
                base.createSubComponent();
            }
        }
        UniDeskMenuItem{
            text: qsTr("删除")
            iconSource: "qrc:/media/img/delete-bin.svg"
            onClicked: {
                base.deleteCom();
            }
        }
    }
    PluginOptions{
        id: options
        comManager: base.comManager
        editingComponent: base
    }
    onRightClicked: {
        menu.popup(cont);
    }
    function propertyData(){
        return {
            "type": base.type,
            "identification": base.identification,
            "pageid": base.pageid,
            "x": base.x,
            "y": base.y,
            "name": base.name,
            "parent": base.parent === comManager.root.contentItem ? "Desktop" : base.parent.identification,
            "rotation": base.rotation,
            "opacity": base.itemOpacity,
            "width": base.width,
            "height": base.height
        }
    }
    function loadPropertyData(data){
        if(data.type!==undefined){base.type=data.type;}
        if(data.identification!==undefined){base.identification=data.identification;}       
        if(data.pageid!==undefined){base.pageid=data.pageid;}
        if(data.x!==undefined){base.x=data.x;}
        if(data.y!==undefined){base.y=data.y;}
        if(data.name!==undefined){base.name=data.name;}
        if(data.parent!==undefined){base.parent=base.comManager.getComById(data.parent);}
        if(data.width!==undefined){base.width=data.width;}
        if(data.height!==undefined){base.height=data.height;}
        if(data.rotation!==undefined){base.rotation=data.rotation;}
        if(data.opacity!==undefined){base.itemOpacity=data.opacity;}else{base.itemOpacity=1;}
    }
    function saveComToFile(){
        var data= propertyData();
        UniDeskComponentsData.updateComponent(base.comManager.getIndexById(base.identification), data);
    }
    onCloseSignal: ()=>{
        if(options){
            options.close();
        }
    }
}