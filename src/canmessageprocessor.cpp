#include "canmessageprocessor.h"

CanMessageProcessor::CanMessageProcessor(QObject *parent)
    : QObject{parent}
{}

void CanMessageProcessor::setMessages(const QList<QCanMessageDescription> &messages){
    m_processor.setMessageDescriptions(messages);
    qDebug() << "QCanFrameProcessor initialized succesfully with " << m_processor.messageDescriptions().count() << " messages.";
}

void CanMessageProcessor::processFrame(const QCanBusFrame &frame){
    if(!frame.isValid()){
        qDebug() << "CAN frame not valid!";
    }

    QCanFrameProcessor::ParseResult result = m_processor.parseFrame(frame);


    //ovaj dio bi se moga optimizirat sa lookup table
    QString messageName;
    for(const auto &desc : m_processor.messageDescriptions()){
        if(desc.uniqueId() == result.uniqueId){
            messageName = desc.name();

            break;
        }
    }


    if(m_processor.error() != QCanFrameProcessor::Error::None){
        qDebug() << "Frame processing failed: " << m_processor.errorString();
        return;
    }

    if(result.signalValues.isEmpty()){
        qDebug() << "Parsing failed: Unique ID " << result.uniqueId << "not found in description.";
        return;
    }


    qDebug() << "Frame ID: " << result.uniqueId << "Message name: " << messageName ;
    QMapIterator<QString, QVariant> i(result.signalValues);
    while (i.hasNext()) {
        i.next();
        qDebug() << "  Signal:" << i.key() << ", Value:" << i.value();
    }

    emit frameDecoded(result.uniqueId, result.signalValues, messageName);
}

void CanMessageProcessor::setUniqueIDDescription(const QCanUniqueIdDescription &idDescription){
    m_processor.setUniqueIdDescription(idDescription);
}


