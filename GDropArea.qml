import QtQuick 2.0
import GDrager 1.0


Rectangle
{

    id:root
    color: dropArea.containsDrag ? "#44FF00FF" : "transparent"
    Text {
        color: "#b4a5a5"
        anchors.fill: parent
        text: qsTr("drop area")
        font.pointSize: 34
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }


    DropArea
    {
        id:dropArea
        anchors.fill: parent

        onDropped: console.log("droped")
        onContainsDragChanged:
        {
            if(containsDrag)
                GDragerCenter.dragTarget=root;
            else if(GDragerCenter.dragTarget == root)
                GDragerCenter.dragTarget=null;

        }



    }


}


