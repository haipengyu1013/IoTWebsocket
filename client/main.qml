import QtQuick 2.5
import QtQuick.Window 2.2
import QtWebSockets 1.0

Window {
    id: mainwindow
    width: 1920
    height: 1080
    color: "white"
    visible: true

    property var checklist: ["1","0","0","0","0","0","0","0","0"]

    Rectangle {
        width: 902
        height: 902
        border.color: "blue"
        border.width: 1
        anchors.centerIn: parent

        Grid {
            anchors.centerIn: parent
            columns: 3
            spacing: 0

            Repeater {
                model: 9
                Rectangle {
                    width: 300
                    height: 300
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

                            socket.sendTextMessage(checklist)
                        }
                    }
                }
            }
        }
    }
    Text {
        id: debugWindow
        width: parent.width
        height: parent.height * 0.4
        anchors.top: mainwindow.bottom
        anchors.topMargin: -100
        color: "white"
    }

    WebSocket {
        id: socket
        url: "ws://10.42.0.1:20000"
        active: true
        onTextMessageReceived: {
            var temp = message.split(",")
            checklist = temp
            console.log("checklist is " + checklist)
        }
        onStatusChanged: {
            debugWindow.text += "socket state is" + socket.status
        }

    }
}
