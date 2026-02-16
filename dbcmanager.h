#ifndef DBCMANAGER_H
#define DBCMANAGER_H

#include <QCanBus>
#include <QCanDbcFileParser>
#include <QCanMessageDescription>
#include <QCanSignalDescription>
#include <QString>

#include <QCanUniqueIdDescription>

class DbcManager
{
public:
    DbcManager();

    bool load(const QString &path);

    QList<QCanMessageDescription> getMessages();

    void printMessages();

    QCanUniqueIdDescription getIdDescription();

private:
    QList<QCanMessageDescription> m_messages;
    QCanDbcFileParser m_parser;
};

#endif // DBCMANAGER_H
