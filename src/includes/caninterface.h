#ifndef CANINTERFACE_H
#define CANINTERFACE_H

#include <QObject>
#include <QDebug>


#include <QtSerialBus/QCanBus>
#include <QtSerialBus/QCanBusFrame>

class CanInterface : public QObject
{
    Q_OBJECT

public:
    explicit CanInterface(QObject *parent = nullptr);


    bool start(const QString &interfaceName);
    void stop();

signals:
    void frameReceived(const QCanBusFrame &frame);
    void errorOccurred(const QString &error);
    void connected();

private slots:
    void onFramesReceived();
    void sendFrame(const QCanBusFrame &frame);
    void onErrorOccurred(QCanBusDevice::CanBusError error);
    void onStateChanged(QCanBusDevice::CanBusDeviceState state);

private:
    QCanBusDevice *m_device = nullptr;
    QString m_interfaceName;
};

#endif // CANINTERFACE_H
