#ifndef DEVICE_H
#define DEVICE_H

#include <QObject>

class Device : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString power READ power WRITE setPower NOTIFY powerChanged)

public:
    Device(QObject *parent = 0);

public:
    QString power() const;
    void setPower(const QString &power);

signals:
    void powerChanged(const QString &power);

protected:
    void timerEvent(QTimerEvent *);

private:
    QString m_power;
};

#endif // DEVICE_H
