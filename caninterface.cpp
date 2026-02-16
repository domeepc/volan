#include "caninterface.h"

CanInterface::CanInterface(QObject *parent)
    : QObject{parent}
{}

bool CanInterface::start(const QString &interfaceName){
    if(m_device) stop();

    m_device = QCanBus::instance()->createDevice("socketcan", interfaceName);


    if(!m_device){
        qWarning() << "CAN device not created!";
        qDebug() << "aaaaa   " << m_device;
        return false;
    }

    //kad primi okvir šali signal
    connect(m_device, &QCanBusDevice::framesReceived, this, &CanInterface::onFramesReceived);

    //ako se greska dogodi posalji error signal
    connect(m_device, &QCanBusDevice::errorOccurred, this, &CanInterface::onErrorOccurred);

    //ako se CAN device iskljuci salji signal
    connect(m_device, &QCanBusDevice:: stateChanged, this, &CanInterface::onStateChanged);



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

        /*ovaj dio je samo testiranje
        QCanBusFrame frame = m_device->readFrame();
        QString frameHexPadded = QString::number(static_cast<quint64>(frame.frameId()), 16).toUpper();
        qDebug() << frameHexPadded;
        emit process(frameHexPadded);
        */


        emit frameReceived(m_device->readFrame());
    }
}


void CanInterface::onErrorOccurred(QCanBusDevice::CanBusError error){
    if (error == QCanBusDevice::NoError) return;

    qDebug() << "CAN error: " << error;

    emit errorOccurred(m_device->errorString());
}

void CanInterface::onStateChanged(QCanBusDevice::CanBusDeviceState state){
    if(state == QCanBusDevice::UnconnectedState){
        emit errorOccurred("CAN interface is disconnected");

    }else if(state == QCanBusDevice::ConnectedState){
        emit errorOccurred("CAN interface is connected!");

    }
}



