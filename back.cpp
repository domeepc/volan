#include "back.h"

Back::Back(QObject *parent) : QObject{parent} { receiveFrames(); }

void Back::receiveFrames() {
  QString errorString;
  receive_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("vcan1"), &errorString);
  if (!receive_device)
    qDebug() << errorString;
  else {
    receive_device->setConfigurationParameter(QCanBusDevice::BitRateKey,
                                              QVariant());
    receive_device->connectDevice();

    QObject::connect(receive_device, &QCanBusDevice::framesReceived, [=]() {
      while (receive_device->framesAvailable()) {
        bool ok;
        QCanBusFrame frame = receive_device->readFrame();
        QByteArray data = frame.payload();
        QByteArray::Iterator it;
        int count = 0;
        for (it = data.begin(); it != data.end(); it++) {
          if (data.size() == 8) {
            QByteArray one_byte(1, 0);
            one_byte[0] = data.at(count++);
            if (count == 1) {
              QString battery_perc = one_byte.toHex().left(2).toUpper();
              uint8_t battery_p_int = battery_perc.toUInt(&ok, 16);
              if (battery_p_int >= 0 && battery_p_int <= 100) {
                emit frameBatPercReceived(battery_p_int);
              } else
                handleError(1);
            } else if (count == 2) {
              QString battery_temp = one_byte.toHex().left(2).toUpper();
              uint8_t battery_temp_int = battery_temp.toUInt(&ok, 16);
              if (battery_temp_int >= 0 && battery_temp_int <= 100) {
                emit frameBatTempReceived(battery_temp_int);
              } else
                handleError(2);
            } else if (count == 3) {
              QString speed = one_byte.toHex().left(2).toUpper();
              uint8_t speed_int = speed.toUInt(&ok, 16);
              if (speed_int >= 0 && speed_int <= 100) {
                emit frameSpeedReceived(speed_int);
              } else
                handleError(1);
            }
          }
        }
      }
    });
  }
}

void Back::debugSendFrame() {
  QString errorString;
  send_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("vcan0"), &errorString);
  if (!send_device)
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
  QString err_msg;
  switch (err_id) {
    case 1:
      err_msg = "Speed can't be over 255 km/h or below 0 km/h";
      emit frameError(err_msg);
      break;
    case 2:
      err_msg = "Speed can't be over 255 km/h or below 0 km/h";
      emit frameError(err_msg);
      break;
    case 3:
      err_msg = "Speed can't be over 255 km/h or below 0 km/h";
      emit frameError(err_msg);
      break;
  }
}

Back::~Back() {
  if (receive_device->state() == QCanBusDevice::ConnectedState) {
    receive_device->disconnectDevice();
  }
  delete receive_device;
}
