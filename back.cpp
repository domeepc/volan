#include "back.h"

Back::Back(QObject *parent) : QObject{parent} { receiveFrames(); }
void Back::receiveFrames() {
  QString errorString;
  receive_device = QCanBus::instance()->createDevice(
      QStringLiteral("socketcan"), QStringLiteral("vcan0"), &errorString);
  if (!receive_device) {
    qDebug() << "Failed to create CAN device:" << errorString;
    return;
  }

  receive_device->setConfigurationParameter(QCanBusDevice::BitRateKey,
                                            QVariant());
  if (!receive_device->connectDevice()) {
    qDebug() << "Failed to connect to CAN device:"
             << receive_device->errorString();
    return;
  }

  QObject::connect(receive_device, &QCanBusDevice::framesReceived, [=]() {
    QCanBusFrame frame;
    QDateTime time = QDateTime::currentDateTimeUtc();
    QByteArray data;
    uint8_t battery_p_int, battery_temp_int, speed_int;
    int frame_id;

    while (receive_device->framesAvailable()) {
      frame = receive_device->readFrame();
      data = frame.payload();
      frame_id = frame.frameId();

      // preskoci ako podatak nije 8 bitova
      if (data.size() != 8) {
        continue;  // Skip this frame but continue processing others
      }

      // Check for FF error patterns first (before processing specific frame
      // types)

      // id baterije = BA5
      // id brzine = BE4

      switch (frame_id) {
        case 0xFFF:
          // Special error frame ID handling
          // Check for FF error patterns: FF FF XX XX YY YY (6 bytes)
          if (static_cast<uint8_t>(data[0]) == 0xFF) {
            handleError(1, 0, time);  // Battery error
          }
          if (static_cast<uint8_t>(data[1]) == 0xFF) {
            handleError(2, 0, time);  // Speed error
          }
          if (static_cast<uint8_t>(data[2]) == 0xFF) {
            handleError(3, 0, time);  // High temperature error
          }

          break;

        case 0xBA5:
          // Optimized battery data processing - work directly with bytes
          if (data.size() >= 2) {
            // Battery percentage from first byte
            battery_p_int = static_cast<uint8_t>(data[0]);

            emit frameBatPercReceived(battery_p_int);

            // Battery temperature from second byte
            battery_temp_int = static_cast<uint8_t>(data[1]);

            emit frameBatTempReceived(battery_temp_int);
          }
          break;

        case 0xBE4:
          // Optimized speed data processing - work directly with bytes
          if (data.size() >= 1) {
            // Speed from first byte
            speed_int = static_cast<uint8_t>(data[0]);

            emit frameSpeedReceived(speed_int);
          }
          break;
      }
    }
  });
}

// mali errorHandler za moguce greske
void Back::handleError(int err_id, uint8_t error_val, QDateTime error_time) {
  QString err_msg;
  switch (err_id) {
    case 1:
      err_msg =
          QStringLiteral("%1 - Battery error detected (FF pattern in payload)")
              .arg(error_time.toString());
      emit frameError(err_msg);
      break;
    case 2:
      err_msg =
          QStringLiteral("%1 - Speed error detected (FF pattern in payload)")
              .arg(error_time.toString());
      emit frameError(err_msg);
      break;
    case 3:
      err_msg =
          QStringLiteral(
              "%1 - High temperature error detected (FF pattern in payload)")
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
