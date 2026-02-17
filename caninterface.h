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
    // mozda dodat funkciju za ponovni pokusaj spajanja na can u slucaju greski




signals:
    void frameReceived(const QCanBusFrame &frame);
    void errorOccurred(const QString &error);


    void process(QString frameid);//ova funkcija je samo za testiranje

private slots:
    void onFramesReceived();
    void sendFrame(const QCanBusFrame &frame);
    void onErrorOccurred(QCanBusDevice::CanBusError error);
    void onStateChanged(QCanBusDevice::CanBusDeviceState state);

private:
    QCanBusDevice *m_device = nullptr;

};

#endif // CANINTERFACE_H
