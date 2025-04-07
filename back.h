#ifndef BACK_H
#define BACK_H

#include <QObject>
#include <QtQml>
#include <QtSerialBus/QCanBus>

class Back : public QObject {
  Q_OBJECT
  QML_ELEMENT
 public:
  explicit Back(QObject *parent = nullptr);
  QCanBusDevice *receive_device;
  QCanBusDevice *send_device;
  void handleError(int);

  ~Back();
 signals:
  void frameSpeedReceived(uint8_t speed_val);
  void frameBatTempReceived(uint8_t bat_t_val);
  void frameBatPercRecevived(uint8_t bat_perc_val);
  void frameError(QString err_msg);
};

#endif  // BACK_H
