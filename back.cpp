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
      bool ok;
      QByteArray::Iterator it;
      QCanBusFrame frame;
      QDateTime time = QDateTime::currentDateTimeUtc();
      QByteArray data;
      QByteArray one_byte(1, 0);
      QString battery_perc;
      uint8_t battery_p_int;
      QString battery_temp;
      uint8_t battery_temp_int;
      QString speed;
      uint8_t speed_int;
      int count;

      while (receive_device->framesAvailable()) {
        frame = receive_device->readFrame();
        count = 0;
        data = frame.payload();

        // preskoci ako podatak nije 8 bitova
        if (data.size() != 8) {
          return;
        }

        // idi kroz petlju i uzimaj 2 po 2 bita (fiksni podatak, sansa za
        // pucanje programa, dosta sporo I believe)
        for (it = data.begin(); it != data.end(); it++) {
          one_byte[0] = data.at(count++);

          switch (count) {
            case 1:
              battery_perc = one_byte.toHex().left(2).toUpper();
              battery_p_int = battery_perc.toUInt(&ok, 16);

              if (!(battery_p_int >= 0 && battery_p_int <= 100)) {
                handleError(1, battery_p_int, time);
                return;
              }

              emit frameBatPercReceived(battery_p_int);

              break;
            case 2:
              battery_temp = one_byte.toHex().left(2).toUpper();
              battery_temp_int = battery_temp.toUInt(&ok, 16);

              if (!(battery_temp_int >= 0 && battery_temp_int <= 100)) {
                handleError(2, battery_temp_int, time);
                return;
              }

              emit frameBatTempReceived(battery_temp_int);

              break;
            case 3:
              speed = one_byte.toHex().left(2).toUpper();
              speed_int = speed.toUInt(&ok, 16);

              if (!(speed_int >= 0 && speed_int <= 255)) {
                handleError(3, speed_int, time);
                return;
              }

              emit frameSpeedReceived(speed_int);

              break;
          }
        }
      }
    });
  }
}

// totalno nepotrbno za sada

/*void Back::debugSendFrame() {
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
*/

// mali errorHandler za moguce greske
void Back::handleError(int err_id, uint8_t error_val, QDateTime error_time) {
  QString err_msg;
  switch (err_id) {
    case 1:
      err_msg = QStringLiteral(
                    "%1 - Battery can't be over 100% or below 0% - val %2%")
                    .arg(error_time.toString())
                    .arg(error_val);
      emit frameError(err_msg);
      break;
    case 2:
      err_msg = QStringLiteral(
                    "%1 - Battery temperature can't be over 100°C or below 0°C "
                    "- val %2°C")
                    .arg(error_time.toString())
                    .arg(error_val);
      emit frameError(err_msg);
      break;
    case 3:
      err_msg = QStringLiteral(
                    "%1 - Speed can't be over 255 km/h or below 0 km/h - val "
                    "%2 km/h")
                    .arg(error_time.toString())
                    .arg(error_val);
      emit frameError(err_msg);
      break;
  }
}

// diskonektaj device kad je gotov program
Back::~Back() {
  if (receive_device->state() == QCanBusDevice::ConnectedState) {
    receive_device->disconnectDevice();
  }
  delete receive_device;
}
