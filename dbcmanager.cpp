#include "dbcmanager.h"

DbcManager::DbcManager() {}


bool DbcManager::load(const QString &path)
{


    if (!m_parser.parse(path))
        return false;

    m_messages = m_parser.messageDescriptions();
    return true;
}

QList<QCanMessageDescription> DbcManager::getMessages(){
    return m_messages;
}

QCanUniqueIdDescription DbcManager::getIdDescription(){
    return m_parser.uniqueIdDescription();
}

void DbcManager::printMessages(){
    for (const auto &msg : m_messages) {
                 qDebug() << "Message:" << msg.name()
                 << "ID:" << msg.uniqueId();

                 for (const auto &sig : msg.signalDescriptions()) {
                     qDebug() << "   Signal:" << sig.name()
                     << "start bit" << sig.startBit()
                     << "length" << sig.bitLength()
                     << "factor" << sig.factor()
                     << "offset" << sig.offset();
                 }
             }

}
