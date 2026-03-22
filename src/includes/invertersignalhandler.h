#ifndef INVERTERSIGNALHANDLER_H
#define INVERTERSIGNALHANDLER_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <unordered_map>
#include <functional>
#include <array>

class InverterSignalHandler : public QObject
{
    Q_OBJECT

    // TEMPERATURES
    Q_PROPERTY(double motorTemperatureL READ motorTemperatureL NOTIFY motorTemperatureChanged)
    Q_PROPERTY(double motorTemperatureR READ motorTemperatureR NOTIFY motorTemperatureChanged)
    Q_PROPERTY(double temperatureL READ temperatureL NOTIFY inverterTemperatureChanged)
    Q_PROPERTY(double temperatureR READ temperatureR NOTIFY inverterTemperatureChanged)

    // SPEED / CURRENT
    Q_PROPERTY(double ERPM_L READ ERPM_L NOTIFY ERPMsChanged)
    Q_PROPERTY(double ERPM_R READ ERPM_R NOTIFY ERPMsChanged)
    Q_PROPERTY(double AC_L READ AC_L NOTIFY ACsChanged)
    Q_PROPERTY(double AC_R READ AC_R NOTIFY ACsChanged)

    // DRIVE ENABLE
    Q_PROPERTY(bool l_drive_enable READ lDriveEnable NOTIFY driveEnableChanged)
    Q_PROPERTY(bool r_drive_enable READ rDriveEnable NOTIFY driveEnableChanged)

    // DIGITAL OUTPUTS
    Q_PROPERTY(bool l_do1 READ l_do1 NOTIFY digitalOutputsChanged)
    Q_PROPERTY(bool l_do2 READ l_do2 NOTIFY digitalOutputsChanged)
    Q_PROPERTY(bool l_do3 READ l_do3 NOTIFY digitalOutputsChanged)
    Q_PROPERTY(bool l_do4 READ l_do4 NOTIFY digitalOutputsChanged)

    Q_PROPERTY(bool r_do1 READ r_do1 NOTIFY digitalOutputsChanged)
    Q_PROPERTY(bool r_do2 READ r_do2 NOTIFY digitalOutputsChanged)
    Q_PROPERTY(bool r_do3 READ r_do3 NOTIFY digitalOutputsChanged)
    Q_PROPERTY(bool r_do4 READ r_do4 NOTIFY digitalOutputsChanged)

public:
    explicit InverterSignalHandler(QObject* parent = nullptr);

    // getters
    double motorTemperatureL() const { return m_motor_temperature_l; }
    double motorTemperatureR() const { return m_motor_temperature_r; }

    double temperatureL() const { return m_inverter_temperature_l; }
    double temperatureR() const { return m_inverter_temperature_r; }

    double ERPM_L() const { return m_erpm_l; }
    double ERPM_R() const { return m_erpm_r; }

    double AC_L() const { return m_ac_l; }
    double AC_R() const { return m_ac_r; }

    bool lDriveEnable() const { return m_drive_enable_l; }
    bool rDriveEnable() const { return m_drive_enable_r; }

    bool l_do1() const { return m_digital_outputs_l[0]; }
    bool l_do2() const { return m_digital_outputs_l[1]; }
    bool l_do3() const { return m_digital_outputs_l[2]; }
    bool l_do4() const { return m_digital_outputs_l[3]; }

    bool r_do1() const { return m_digital_outputs_r[0]; }
    bool r_do2() const { return m_digital_outputs_r[1]; }
    bool r_do3() const { return m_digital_outputs_r[2]; }
    bool r_do4() const { return m_digital_outputs_r[3]; }

signals:
    void motorTemperatureChanged();
    void inverterTemperatureChanged();
    void ERPMsChanged();
    void ACsChanged();
    void driveEnableChanged();
    void digitalOutputsChanged();

public slots:
    void processSignal(const QString& name, const QVariant& value, const QString &messageName);

private:
    std::unordered_map<QString, std::function<void(const QVariant&)>> signal_map;

    // temps
    double m_motor_temperature_l = 0.0;
    double m_motor_temperature_r = 0.0;
    double m_inverter_temperature_l = 0.0;
    double m_inverter_temperature_r = 0.0;

    // electrical
    double m_erpm_l = 0.0;
    double m_erpm_r = 0.0;
    double m_ac_l = 0.0;
    double m_ac_r = 0.0;

    // states
    bool m_drive_enable_l = false;
    bool m_drive_enable_r = false;

    // bitfields
    std::array<bool, 4> m_digital_outputs_l = {false, false, false, false};
    std::array<bool, 4> m_digital_outputs_r = {false, false, false, false};

    std::array<bool, 8> m_fault_code_l = {};
    std::array<bool, 8> m_fault_code_r = {};

    std::array<bool, 3> m_limit_bits_l = {};
    std::array<bool, 3> m_limit_bits_r = {};
};

#endif // INVERTERSIGNALHANDLER_H
