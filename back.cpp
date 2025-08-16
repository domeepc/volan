#include "back.h"

Back::Back(QObject *parent) : QObject{parent} { receiveFrames(); }
void Back::receiveFrames() {
  QString errorString;
  receive_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("can0"), &errorString);
  if (!receive_device) {
    qDebug() << "Failed to create CAN device:" << errorString;
    return;
  }
  
  receive_device->setConfigurationParameter(QCanBusDevice::BitRateKey,
                                            QVariant());
  if (!receive_device->connectDevice()) {
    qDebug() << "Failed to connect to CAN device:" << receive_device->errorString();
    return;
  }

    QObject::connect(receive_device, &QCanBusDevice::framesReceived, [=]() {
      QCanBusFrame frame;
      QDateTime time = QDateTime::currentDateTimeUtc();
      QByteArray data;
      uint8_t battery_p_int, battery_temp_int, speed_int;
      int battery_perc_limit_low, battery_perc_limit_high,
          battery_temp_limit_low, battery_temp_limit_high, speed_limit_low,
          speed_limit_high, frame_id;

      battery_perc_limit_low = battery_temp_limit_low = speed_limit_low = 0;
      battery_perc_limit_high = battery_temp_limit_high = 100;
      speed_limit_high = 255;

      while (receive_device->framesAvailable()) {
        frame = receive_device->readFrame();
        data = frame.payload();
        frame_id = frame.frameId();

        // preskoci ako podatak nije 8 bitova
        if (data.size() != 8) {
          continue; // Skip this frame but continue processing others
        }

        // Check for FF error patterns first (before processing specific frame types)
        if (data.size() >= 6) {
          // Check for FF error patterns: FF FF XX XX YY YY (6 bytes)
          if (static_cast<uint8_t>(data[0]) == 0xFF && static_cast<uint8_t>(data[1]) == 0xFF) {
            handleError(4, 0, time); // Battery error
            return;
          }
          if (static_cast<uint8_t>(data[2]) == 0xFF && static_cast<uint8_t>(data[3]) == 0xFF) {
            handleError(5, 0, time); // Speed error
            return;
          }
          if (static_cast<uint8_t>(data[4]) == 0xFF && static_cast<uint8_t>(data[5]) == 0xFF) {
            handleError(6, 0, time); // High temperature error
            return;
          }
        }

        // id baterije = BA5
        // id brzine = BE4
        
        switch (frame_id) {
          case 0xFFF:
            // Special error frame ID handling
            handleError(7, 0, time);
            return;
            
          case 0xBA5:
            // Optimized battery data processing - work directly with bytes
            if (data.size() >= 2) {
              // Battery percentage from first byte
              battery_p_int = static_cast<uint8_t>(data[0]);
              
              if (!(battery_p_int >= battery_perc_limit_low &&
                    battery_p_int <= battery_perc_limit_high)) {
                handleError(1, battery_p_int, time);
                return;
              }
              
              emit frameBatPercReceived(battery_p_int);
              
              // Battery temperature from second byte
              battery_temp_int = static_cast<uint8_t>(data[1]);
              
              if (!(battery_temp_int >= battery_temp_limit_low &&
                    battery_temp_int <= battery_temp_limit_high)) {
                handleError(2, battery_temp_int, time);
                return;
              }
              
              emit frameBatTempReceived(battery_temp_int);
            }
            break;
            
          case 0xBE4:
            // Optimized speed data processing - work directly with bytes
            if (data.size() >= 1) {
              // Speed from first byte
              speed_int = static_cast<uint8_t>(data[0]);
              
              if (!(speed_int >= speed_limit_low &&
                    speed_int <= speed_limit_high)) {
                handleError(3, speed_int, time);
                return;
              }
              
              emit frameSpeedReceived(speed_int);
            }
            break;
        }
      }
    });
}

// totalno nepotrebno za sada

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
    case 4:
      err_msg = QStringLiteral(
                    "%1 - Battery error detected (FF FF pattern in payload)")
                    .arg(error_time.toString());
      emit frameError(err_msg);
      break;
    case 5:
      err_msg = QStringLiteral(
                    "%1 - Speed error detected (FF FF pattern in payload)")
                    .arg(error_time.toString());
      emit frameError(err_msg);
      break;
    case 6:
      err_msg = QStringLiteral(
                    "%1 - High temperature error detected (FF FF pattern in payload)")
                    .arg(error_time.toString());
      emit frameError(err_msg);
      break;
    case 7:
      err_msg = QStringLiteral(
                    "%1 - Critical error detected (Frame ID 0xFFF)")
                    .arg(error_time.toString());
      emit frameError(err_msg);
      break;
  }
}

// diskonektaj device kad je gotov program
Back::~Back() {
  if (receive_device) {
    if (receive_device->state() == QCanBusDevice::ConnectedState) {
      receive_device->disconnectDevice();
    }
    delete receive_device;
  }
  if (send_device) {
    if (send_device->state() == QCanBusDevice::ConnectedState) {
      send_device->disconnectDevice();
    }
    delete send_device;
  }
}
