#include "signalhandler.h"

SignalHandler::SignalHandler(QObject *parent)
    : QObject{parent}
{

}


void SignalHandler::handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs)
{

    //qDebug() << "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    switch(id){
        case QtCanBus::UniqueId(0x7B):
        qDebug() << "asdasdasdasdasd";
        m_speed = sigs["SPEED"].toDouble();
        emit speedChanged();
        break;
    default:
        qDebug() << "Unkown CAN id: " << id ;
        break;
    }
}
