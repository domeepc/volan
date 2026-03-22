#include "signalhandler.h"

SignalHandler::SignalHandler(QObject *parent)
    : QObject{parent}
{

}

void SignalHandler::handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs, const QString &messageName) {

    for(auto it = sigs.begin(); it != sigs.end(); ++it){
        const QString& name = it.key();
        const QVariant& value = it.value();

        if (name.startsWith("VCU_")){
            m_vcu.processSignal(name, value, messageName);
        }
        else if (name.startsWith("BMS_")){
            m_bms.processSignal(name, value, messageName);
        }
        else if (name.startsWith("Inverter")){
            m_inverter.processSignal(name, value, messageName);
        }
    }
}


