#ifndef BACK_H
#define BACK_H

#include <QObject>
#include <QtQml>
#include <QtSerialBus/QCanBus>

class Back : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Back(QObject *parent = nullptr);
    QCanBusDevice *receive_device;
    QCanBusDevice *send_device;
    ~Back();
signals:
    void frameReceived(uint8_t msg);
};

#endif // BACK_H
