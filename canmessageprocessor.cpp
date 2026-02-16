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
    if(m_processor.error() != QCanFrameProcessor::Error::None){
        qDebug() << "Frame processing failed: " << m_processor.errorString();
        return;
    }

    if(result.signalValues.isEmpty()){
        qDebug() << "Parsing failed: Unique ID " << result.uniqueId << "not found in description.";
        return;
    }

    qDebug() << "Frame ID: " << result.uniqueId;




    //emit frameDecoded(result.uniqueId, result.signalValues);
}

void CanMessageProcessor::setUniqueIDDescription(const QCanUniqueIdDescription &idDescription){
    m_processor.setUniqueIdDescription(idDescription);
}


