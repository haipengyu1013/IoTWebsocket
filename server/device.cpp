#include <QProcess>
#include <QDebug>

#include "device.h"

Device::Device(QObject *parent)
    : QObject(parent)
{
    QProcess::execute("gpio mode 7 out");
    startTimer(100);
}

QString Device::power() const
{
    return m_power;
}

void Device::setPower(const QString &power)
{
    QProcess::execute(QString("gpio write 7 %1").arg(power));
}

void Device::timerEvent(QTimerEvent *)
{
    QProcess process;
    process.start("gpio read 7", QIODevice::ReadOnly);
    process.waitForFinished();

    QString power = QString(process.readAllStandardOutput()).left(1);

    if (m_power != power) {
        m_power = power;
        emit powerChanged(power);
    }
}
