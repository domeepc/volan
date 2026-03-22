#ifndef BMSSIGNALHANDLER_H
#define BMSSIGNALHANDLER_H

#include <QObject>
#include <QString>
#include <QVariant>
#include <QVector>
#include <unordered_map>
#include <functional>
#include <array>

class BmsSignalHandler : public QObject
{
    Q_OBJECT

    // STATES
    Q_PROPERTY(QString state READ state NOTIFY statesChanged)
    Q_PROPERTY(bool airPlus READ airPlus NOTIFY statesChanged)
    Q_PROPERTY(bool airMinus READ airMinus NOTIFY statesChanged)
    Q_PROPERTY(bool precharge READ precharge NOTIFY statesChanged)
    Q_PROPERTY(bool imdOk READ imdOk NOTIFY statesChanged)

    // VALUES
    Q_PROPERTY(double totalCurrent READ totalCurrent NOTIFY valuesChanged)
    Q_PROPERTY(double totalVoltage READ totalVoltage NOTIFY valuesChanged)

    // SOC / SOH / SOP
    Q_PROPERTY(double soc READ soc NOTIFY stateOfBatteryValuesChanged)
    Q_PROPERTY(double soh READ soh NOTIFY stateOfBatteryValuesChanged)
    Q_PROPERTY(double sop READ sop NOTIFY stateOfBatteryValuesChanged)

    Q_PROPERTY(double maxTemperature READ maxTemperature NOTIFY temperaturesChanged)
    Q_PROPERTY(double avgTemperature READ avgTemperature NOTIFY temperaturesChanged)

    // TEMPERATURES / VOLTAGES
    Q_PROPERTY(QVector<double> voltageMin READ voltageMin NOTIFY voltagesChanged)
    Q_PROPERTY(QVector<double> voltageMax READ voltageMax NOTIFY voltagesChanged)

    Q_PROPERTY(QVector<double> temperatureMin READ temperatureMin NOTIFY temperaturesChanged)
    Q_PROPERTY(QVector<double> temperatureAvg READ temperatureAvg NOTIFY temperaturesChanged)
    Q_PROPERTY(QVector<double> temperatureMax READ temperatureMax NOTIFY temperaturesChanged)

    Q_PROPERTY(QVector<double> ntcTemperature READ ntcTemperature NOTIFY ntcChanged)

public:
    explicit BmsSignalHandler(QObject* parent = nullptr);

    // getters
    QString state() const { return m_state; }
    bool airPlus() const { return m_air_plus; }
    bool airMinus() const { return m_air_minus; }
    bool precharge() const { return m_precharge; }
    bool imdOk() const { return m_imd_ok; }

    double totalCurrent() const { return m_total_current; }
    double totalVoltage() const { return m_total_voltage; }

    double soc() const { return m_soc; }
    double soh() const { return m_soh; }
    double sop() const { return m_sop; }

    double avgTemperature() const;
    double maxTemperature() const;

    QVector<double> voltageMin() const;
    QVector<double> voltageMax() const;

    QVector<double> temperatureMin() const;
    QVector<double> temperatureAvg() const;
    QVector<double> temperatureMax() const;

    QVector<double> ntcTemperature() const;

signals:

    void statesChanged();
    void valuesChanged();
    void stateOfBatteryValuesChanged();
    void voltagesChanged();
    void temperaturesChanged();
    void ntcChanged();

public slots:

    void processSignal(const QString& name, const QVariant& value, const QString &messageName);
    void processFrame(const QString& messageName, const QMap<QString, QVariant>& sigs);

private:
    std::unordered_map<QString, std::function<void(const QVariant&)>> signal_map;

    struct ValueStats {
        double min = 80;
        double max = -20;
        double sum = 0.0;
        int count = 0;
        uint messageCount = 0;

        void reset() {
            min = 80;
            max = -20;
            sum = 0.0;
            count = 0;
            messageCount = 0;
        }

        void update(double t) {
            if (t < -20 || t > 80) return;
            min = std::min(min, t);
            max = std::max(max, t);
            sum += t;
            count++;
        }

        double avg() const {
            return count ? sum / count : 0;
        }
    };

    // states
    QString m_state = "default";
    bool m_air_plus = false;
    bool m_air_minus = false;
    bool m_precharge = false;
    bool m_imd_ok = false;

    // values
    double m_total_current = 0.0;
    double m_total_voltage = 0.0;

    // battery state
    double m_soc = 0.0;
    double m_soh = 0.0;
    double m_sop = 0.0;

    // ntc
    std::array<double, 2> m_ntc_temperatures = {0.0, 0.0};

    // modules
    std::array<ValueStats, 6> module_temperatures;
    std::array<ValueStats, 6> module_voltages;


    // dodaj 2 varijable za pratit prosjecnu i maksimalnu temperataturu cijelog paketa
};

#endif // BMSSIGNALHANDLER_H
