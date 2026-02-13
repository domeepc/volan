#include "caninterface.h"

CanInterface::CanInterface(QObject *parent)
    : QObject{parent}
{}

bool CanInterface::start(const QString &interfaceName){
    if(m_device) stop();

    m_device = QCanBus::instance()->createDevice("socketcan", interfaceName);
    if(!m_device){
        qDebug() << "CAN device not created!";
        return false;
    }

    //Signal frame received ----->   onFrameReceived slot
    connect(m_device, &QCanBusDevice::framesReceived, this, &CanInterface::onFramesReceived);

    connect(m_device, &QCanBusDevice::errorOccurred, this, &CanInterface::onErrorOccurred);

    //mozda dodat funkciju da javi je li se can iskljucia

    if(!m_device->connectDevice()){
        emit errorOccurred("Cannot connect CAN device!");
        delete m_device;
        m_device = nullptr;
        return false;
    }


    return true;
}

void CanInterface::stop(){
    if(!m_device) return;

    m_device->disconnectDevice();
    delete m_device;
    m_device = nullptr;
}

void CanInterface::onFramesReceived(){
    while(m_device->framesAvailable()){

        QCanBusFrame frame = m_device->readFrame();

        QString frameHexPadded = QString::number(static_cast<quint64>(frame.frameId()), 16).toUpper();
        qDebug() << frameHexPadded;
        emit process(frameHexPadded);

        //emit frameReceived(m_device->readFrame());
    }
}


void CanInterface::onErrorOccurred(QCanBusDevice::CanBusError error){
    if (error == QCanBusDevice::NoError) return;

    qDebug() << "CAN error: " << error;

    emit errorOccurred(m_device->errorString());
}





