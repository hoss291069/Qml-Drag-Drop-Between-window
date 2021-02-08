import QtQuick 2.0
import GDrager 1.0


Rectangle
{

    id:root
    property color defaultcolor:"transparent"
    color: root.containsDrag ? "#FFFF00FF" : defaultcolor
    property bool containsDrag: dropArea.containsDrag && GDragerCenter.dragTarget === root
    property alias keys: dropArea.keys


    Text {
        id:tex
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

        onPositionChanged:
        {
            if(GDragerCenter.dragTarget!==root);
                containsDragChanged();
        }

        onContainsDragChanged:
        {
            if(containsDrag)
            {
                if(GDragerCenter.dragTarget!==null && GDragerCenter.dragTarget !== root)
                {
//                    if(GDragerCenter.dragTarget.Window !== root.Window)
//                    {
                        if(WindZ.getZOrder(root) >= WindZ.getZOrder(GDragerCenter.dragTarget))
                            GDragerCenter.dragTarget=root;
//                    }
//                    else
//                        GDragerCenter.dragTarget=root;


                }
                else
                    GDragerCenter.dragTarget=root;
            }
            else if(GDragerCenter.dragTarget === root)
                GDragerCenter.dragTarget=null;

        }



    }


}


