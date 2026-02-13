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
    //~CanInterface();

    bool start(const QString &interfaceName);
    void stop();

    bool sendFrame(const QCanBusFrame &frame);


signals:
    void frameReceived(const QCanBusFrame &frame);
    void errorOccurred(const QString &error);
    void process(QString frameid);

private slots:
    void onFramesReceived();
    void onErrorOccurred(QCanBusDevice::CanBusError error);

private:
    QCanBusDevice *m_device = nullptr;
};

#endif // CANINTERFACE_H
