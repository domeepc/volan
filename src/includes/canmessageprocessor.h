#ifndef CANMESSAGEPROCESSOR_H
#define CANMESSAGEPROCESSOR_H

#include <QObject>
#include <QVariantMap>

#include <QCanFrameProcessor>
#include <QCanMessageDescription>
#include <QCanUniqueIdDescription>
#include <QCanBusFrame>
#include <QCanBus>


class CanMessageProcessor : public QObject
{
    Q_OBJECT
public:
    explicit CanMessageProcessor(QObject *parent = nullptr);

    void setMessages(const QList<QCanMessageDescription> &messages);
    void setUniqueIDDescription(const QCanUniqueIdDescription &idDescription);


signals:
    void frameDecoded(QtCanBus::UniqueId id, const QVariantMap &sigs);

public slots:
    void processFrame(const QCanBusFrame &frame);
private:
    QCanFrameProcessor m_processor;
};

#endif // CANMESSAGEPROCESSOR_H
