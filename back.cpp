#include "back.h"

Back::Back(QObject *parent) : QObject{parent} {
  QString errorString;
  QCanBusDevice *receive_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("vcan1"), &errorString);
  if (!receive_device)
    qDebug() << errorString;
  else {
    receive_device->setConfigurationParameter(QCanBusDevice::BitRateKey,
                                              QVariant());
    receive_device->connectDevice();
    receive_device->connect(
        receive_device, &QCanBusDevice::framesReceived, [this, receive_device] {
          bool ok;
          QCanBusFrame frame = receive_device->readFrame();
          QByteArray data = frame.payload();
          QString battery_perc = data.toHex().left(2).toUInt();
          data[0] >>= 1;
          QString battery_temp = data.toHex().left(2).toUInt();
          data[0] >>= 1;
          QString speed = data.toHex().left(2).toUInt();
          data[0] >>= 1;
          uint8_t speed_int = speed.toUint(&ok, 16);
          uint8_t battery_temp.toUInt(&ok, 16);
          uint8_t battery_p_int = battery_perc.toUInt(&ok, 16);

          if (speed_int <= 255 && speed_int >= 0) {
            emit frameSpeedReceived(speed_int);
          } else
            emit handleError(1);
          if (battery_temp <= 100 && speed_int >= 0) {
            emit frameSpeedReceived(speed_int);
          } else
            emit handleError(2);
          if (battery_perc <= 100 && speed_int >= 0) {
            emit frameSpeedReceived(speed_int);
          } else
            emit handleError(3);
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

void Back::handleError(int err_id) {
  switch (err_id):
case 1:
    QString err_msg = "Speed can't be over 255 km/h or below 0 km/h";
    emit frameError(err_msg);
  case 2:
    QString err_msg = "Speed can't be over 255 km/h or below 0 km/h";
    emit frameError(err_msg);
  case 3:
    QString err_msg = "Speed can't be over 255 km/h or below 0 km/h";
    emit frameError(err_msg);
}

Back::~Back() {
  if (receive_device->state() == QCanBusDevice::ConnectedState) {
    receive_device->disconnectDevice();
  }
  delete receive_device;
}
