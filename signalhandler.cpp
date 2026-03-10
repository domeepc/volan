#include "signalhandler.h"

SignalHandler::SignalHandler(QObject *parent)
    : QObject{parent}
{
}

void SignalHandler::handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs)
{
    switch(id){
        case QtCanBus::UniqueId(0x7B):
        qDebug() << "asdasdasdasdasd";
        m_speed = sigs["SPEED"].toDouble();
        m_soc = sigs["SOC"].toDouble(),
        emit speedChanged();
        emit stateOfBatteryValuesChanged();
        break;
    default:
        qDebug() << "Unkown CAN id: " << id ;
        break;
    }
}
