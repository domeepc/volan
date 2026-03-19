#ifndef BMSSIGNALHANDLER_H
#define BMSSIGNALHANDLER_H

#include <QObject>
#include <QVariantMap>
#include <QCanFrameProcessor>
#include <QCanBusFrame>
#include <QCanBus>
#include <algorithm>
#include <limits>
#include <unordered_map>
#include <functional>

class BmsSignalHandler
{
//     Q_OBJECT

//     // BMS
//     Q_PROPERTY(QString bmsState READ bmsState NOTIFY bmsStatesChanged)
//     Q_PROPERTY(bool air_plus READ airPlus NOTIFY bmsStatesChanged)
//     Q_PROPERTY(bool air_minus READ airMinus NOTIFY bmsStatesChanged)
//     Q_PROPERTY(bool precharge READ precharge NOTIFY bmsStatesChanged)
//     Q_PROPERTY(bool imd_ok READ IMD_ok NOTIFY bmsStatesChanged)

//     Q_PROPERTY(double bmsTotalCurrent READ bmsTotalCurrent NOTIFY bmsValuesChanged)
//     Q_PROPERTY(double bmsTotalVoltage READ bmsTotalVoltage NOTIFY bmsValuesChanged)
//     Q_PROPERTY(double bms_total_voltage READ bmsTotalVoltage NOTIFY bmsValuesChanged)
//     Q_PROPERTY(double battery_avg_temp READ battery_avg_temp NOTIFY bmsValuesChanged)

//     Q_PROPERTY(double soc READ soc NOTIFY stateOfBatteryValuesChanged)
//     Q_PROPERTY(double sop READ sop NOTIFY stateOfBatteryValuesChanged)
//     Q_PROPERTY(double soh READ soh NOTIFY stateOfBatteryValuesChanged)


//     Q_PROPERTY(double ntc_temperature1 READ NTC_Temperature1 NOTIFY NTC_TemperaturesChanged)
//     Q_PROPERTY(double ntc_temperature2 READ NTC_Temperature2 NOTIFY NTC_TemperaturesChanged)

//     Q_PROPERTY(QVector<double> voltageMin READ voltageMin NOTIFY bmsVoltagesChanged)
//     Q_PROPERTY(QVector<double> voltageMax READ voltageMax NOTIFY bmsVoltagesChanged)

//     Q_PROPERTY(QVector<double> temperatureMin READ temperatureMin NOTIFY bmsTempsChanged)
//     Q_PROPERTY(QVector<double> temperatureAvg READ temperatureAvg NOTIFY bmsTempsChanged)
//     Q_PROPERTY(QVector<double> temperatureMax READ temperatureMax NOTIFY bmsTempsChanged)

// public slots:

//     void handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs, const QString &messageName);

// signals:

//     void stateOfBatteryValuesChanged();
//     void bmsStatesChanged();
//     void bmsValuesChanged();
//     void NTC_TemperaturesChanged();
//     void bmsVoltagesChanged();
//     void bmsTempsChanged();

// public:
//     BmsSignalHandler();

//     //bms
//     bool airPlus() const{return m_air_plus;};
//     bool airMinus() const{return m_air_minus;};
//     bool precharge() const{return m_precharge;};
//     bool IMD_ok() const {return m_imd_ok;};
//     QString bmsState() const {return m_bms_state;};

//     double bmsTotalCurrent() const {return m_total_current;};
//     double bmsTotalVoltage() const {return m_total_voltage;};
//     double battery_avg_temp() const {
//         double sum = 0;
//         for(int i = 0; i < 6; i++) {
//             sum += module_temperatures[i].sum;
//         }
//         return sum/6;
//     };


//     QVector<double> voltageMin() const;
//     QVector<double> voltageMax() const;

//     QVector<double> temperatureMin() const;
//     QVector<double> temperatureAvg() const;
//     QVector<double> temperatureMax() const;
// private:

//     std::unordered_map<QString, std::function<void(const QVariant&)>> signal_map;

//     bool m_air_plus = false;
//     bool m_air_minus = false;
//     bool m_precharge = false;
//     bool m_imd_ok = false;
//     QString m_bms_state = "default";

//     double m_total_current = 0.0;
//     double m_total_voltage = 0.0;// nije u dbc fajl

//     double m_sop = 0.0;
//     double m_soc = 0.0;
//     double m_soh = 0.0;

//     double m_ntc_temperatures[2] = {0.0, 0.0};//nisu u dbc fajlu

//     struct ValueStats {
//         double min = 80;
//         double max = -20;
//         double sum = 0.0;
//         int count = 0;

//         uint messageCount = 0;

//         void reset() {
//             min = 80;
//             max = -20;
//             sum = 0.0;
//             count = 0;
//             messageCount = 0;
//         }

//         void update(double t) {
//             if(t < -20 || t > 80)
//                 return;

//             min = std::min(min, t);
//             max = std::max(max, t);
//             sum += t;
//             count++;
//         }

//         double avg() const {
//             return count ? sum / count : 0;
//         }

//         void printStats() const {
//             qDebug() << min << avg() << max;
//         }


//     };

//     std::array<ValueStats, 6> module_temperatures;

//     std::array<ValueStats, 6> module_voltages;
};

#endif // BMSSIGNALHANDLER_H
