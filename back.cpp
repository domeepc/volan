#include "back.h"

Back::Back(QObject *parent) : QObject{parent} {
  QString errorString, errorString2;
  QCanBusDevice *receive_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("vcan1"), &errorString);
  if (!receive_device)
    qDebug() << errorString;
  else {
    receive_device->setConfigurationParameter(QCanBusDevice::BitRateKey,
                                              QVariant());
    receive_device->connectDevice();
    receive_device->connect(receive_device, &QCanBusDevice::framesReceived,
                            [this, receive_device] {
                                bool ok;
                              QCanBusFrame frame = receive_device->readFrame();
                              QByteArray data = frame.payload();
                              QString str = data.toHex().left(2).toUpper();
                              uint8_t data_int = str.toUInt(&ok,16);
                              emit frameReceived(data_int);
                            });
  }

  QCanBusDevice *send_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("vcan0"), &errorString);
  if (!receive_device)
    qDebug() << errorString;
  else {
    send_device->setConfigurationParameter(QCanBusDevice::BitRateKey,
                                           QVariant());
    send_device->connectDevice();

    QCanBusFrame frame;
    QByteArray ba;
    ba.resize(8);
    ba[0] = 0x61;
    ba[1] = 0x64;
    ba[2] = 0x11;
    ba[3] = 0x64;
    ba[4] = 0xFF;
    ba[5] = 0xFF;
    ba[6] = 0xFF;
    ba[7] = 0xFF;
    frame.setPayload(ba);
    send_device->writeFrame(frame);
  }
}

Back::~Back() {
  if (receive_device->state() == QCanBusDevice::ConnectedState) {
    receive_device->disconnectDevice();
  }
  delete receive_device;
}
