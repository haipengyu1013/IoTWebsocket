import QtQuick 2.5
import QtWebSockets 1.0

Rectangle {
    id: root
    width: 600
    height: 600

    property WebSocket socket
    property var checklist: ["1","0","0","0","0","0","0","0","0"]


    Grid {
        columns: 3
        spacing: 0

        Repeater {
            model: 9
            Rectangle {
                width: 200
                height: 200
                radius: 4
                scale: mousearea.pressed ? 0.7 : 1
                border.width: checklist[index] === "1" ? 2 : 0
                border.color: checklist[index] === "1" ? "red" : "white"
                color: mousearea.pressed ? "yellow" :
                                           (checklist[index] === "1" ? "lightyellow" : "white")

                Behavior on scale {
                    NumberAnimation {
                        duration: 500
                    }
                }

                MouseArea {
                    id: mousearea
                    anchors.fill: parent
                    onClicked: {
                        var i
                        var tmp
                        tmp = checklist
                        for (i = 0; i < 9; i++) {
                            if(i === index)
                                tmp[i] = "1"
                            else
                                tmp[i] = "0"
                        }
                        checklist = tmp

                        console.log("send message" + root.checklist)
                        socket.sendTextMessage(root.checklist)
                    }
                }
            }
        }
    }


    Connections {
        target: socket

        onStatusChanged: {
            if (socket.status === WebSocket.Closed ||
                    socket.status === WebSocket.Error)
                root.destroy()
        }

        onTextMessageReceived: {
            var temp = message.split(",")
            root.checklist = temp
            console.log("checklist is " + root.checklist)
        }
    }
}
