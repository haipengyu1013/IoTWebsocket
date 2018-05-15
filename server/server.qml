import QtWebSockets 1.0
import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: mainwindow
    width: 600
    height: 600
    color: "white"
    visible: true


    WebSocketServer {
        id: root
        host: "10.42.0.1"
        port: 20000
        listen: true

        onClientConnected: {
            console.log("onClientConnected")
            var component = Qt.createComponent("qrc:/connection.qml").createObject(mainwindow , {"x": 0, "y": 0 })
            component.socket = webSocket
        }

        onErrorStringChanged: {
            console.log(qsTr("Server error: %1").arg(errorString));
        }

    }



}
