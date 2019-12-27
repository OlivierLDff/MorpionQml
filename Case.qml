import QtQuick 2.0

Item
{
    id: root
    property int size: 100
    width: size
    height: size

    property int state: 0
    property bool evaluate

    Rectangle
    {
        visible: root.state === 1
        anchors.centerIn: parent
        rotation: 45
        color: "black"
        width: 2
        height: parent.height
    }

    Rectangle
    {
        visible: root.state === 1
        anchors.centerIn: parent
        rotation: -45
        color: "black"
        width: 2
        height: parent.height
    }

    Rectangle
    {
        visible: root.state === 2
        anchors.centerIn: parent
        width: parent.width*0.8
        height: parent.height*0.8
        border.color: "black"
        border.width: 3

        radius: width/2
    }
}
