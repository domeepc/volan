#ifndef SIGNALHANDLER_H
#define SIGNALHANDLER_H

#include <QObject>
#include <QVariantMap>
#include <QCanFrameProcessor>
#include <QCanBusFrame>
#include <QCanBus>

#include <bmssignalhandler.h>
#include <vcusignalhandler.h>
#include <invertersignalhandler.h>


class SignalHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(VcuSignalHandler* vcu READ vcu CONSTANT)
    Q_PROPERTY(BmsSignalHandler* bms READ bms CONSTANT)
    Q_PROPERTY(InverterSignalHandler* inverter READ inverter CONSTANT)


public:
    explicit SignalHandler(QObject *parent = nullptr);

    VcuSignalHandler* vcu() { return &m_vcu; };
    BmsSignalHandler* bms() { return &m_bms; };
    InverterSignalHandler* inverter() { return &m_inverter; };

public slots:
    void handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs, const QString &messageName);

signals:


private:
    VcuSignalHandler m_vcu;
    BmsSignalHandler m_bms;
    InverterSignalHandler m_inverter;



};

#endif // SIGNALHANDLER_H
