TEMPLATE      = app
QT           += qml quick websockets
SOURCES      += main.cpp \
                device.cpp
HEADERS      += device.h
RESOURCES    += qml.qrc

include(deployment.pri)
