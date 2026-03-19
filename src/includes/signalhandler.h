#ifndef SIGNALHANDLER_H
#define SIGNALHANDLER_H

#include <QObject>
#include <QVariantMap>
#include <QCanFrameProcessor>
#include <QCanBusFrame>
#include <QCanBus>
#include <algorithm>
//#include <limits>
#include <unordered_map>
#include <functional>


class SignalHandler : public QObject
{
    Q_OBJECT

    // VCU
    Q_PROPERTY(double slip READ slip NOTIFY slipChanged)
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(QString mode READ mode NOTIFY modeChanged)
    Q_PROPERTY(QString preset READ preset NOTIFY presetChanged)
    Q_PROPERTY(QString vcuState READ vcuState NOTIFY vcuStateChanged)

    Q_PROPERTY(double brakePressureForward READ brakePressureForward NOTIFY brakePressureChanged)
    Q_PROPERTY(double brakePressureRear READ brakePressureRear NOTIFY brakePressureChanged)
    Q_PROPERTY(double apps1 READ apps1 NOTIFY appsChanged)
    Q_PROPERTY(double apps2 READ apps2 NOTIFY appsChanged)
    Q_PROPERTY(double sw1 READ sw1 NOTIFY swAngleChanged)
    Q_PROPERTY(double sw2 READ sw2 NOTIFY swAngleChanged)

    Q_PROPERTY(double torque_l READ torqueL NOTIFY torqueChanged)
    Q_PROPERTY(double torque_r READ torqueR NOTIFY torqueChanged)

    Q_PROPERTY(double c_factor1 READ cFactor1 NOTIFY cFactorsChanged)
    Q_PROPERTY(double c_factor2 READ cFactor2 NOTIFY cFactorsChanged)
    Q_PROPERTY(double c_factor3 READ cFactor3 NOTIFY cFactorsChanged)
    Q_PROPERTY(double c_factor4 READ cFactor4 NOTIFY cFactorsChanged)

    Q_PROPERTY(double accelerationX READ accelerationX NOTIFY imuValuesChanged)
    Q_PROPERTY(double accelerationY READ accelerationY NOTIFY imuValuesChanged)
    Q_PROPERTY(double accelerationZ READ accelerationZ NOTIFY imuValuesChanged)
    Q_PROPERTY(double gyroZ READ gyroZ NOTIFY imuValuesChanged)

    Q_PROPERTY(double vcuCurrent READ vcuCurrent NOTIFY vcuCurrentChanged)

    // INVERTERI
    Q_PROPERTY(double motorTemperatureL READ motorTemperatureL NOTIFY motorTemperatureChanged)
    Q_PROPERTY(double motorTemperatureR READ motorTemperatureR NOTIFY motorTemperatureChanged)
    Q_PROPERTY(double rpm_l READ rpmL NOTIFY rpmChanged)
    Q_PROPERTY(double rpm_r READ rpmR NOTIFY rpmChanged)
    Q_PROPERTY(double inverterTemperatureL READ inverterTemperatureL NOTIFY inverterTemperatureChanged)
    Q_PROPERTY(double inverterTemperatureR READ inverterTemperatureR NOTIFY inverterTemperatureChanged)

    Q_PROPERTY(double ERPM_L READ ERPM_L NOTIFY ERPMsChanged)
    Q_PROPERTY(double ERPM_R READ ERPM_R NOTIFY ERPMsChanged)

    Q_PROPERTY(double AC_L READ AC_L NOTIFY ACsChanged)
    Q_PROPERTY(double AC_R READ AC_R NOTIFY ACsChanged)

    Q_PROPERTY(bool l_digital_output1 READ LdigitalOutput1 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool l_digital_output2 READ LdigitalOutput2 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool l_digital_output3 READ LdigitalOutput3 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool l_digital_output4 READ LdigitalOutput4 NOTIFY DigitalOutputsChanged)

    Q_PROPERTY(bool r_digital_output1 READ RdigitalOutput1 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool r_digital_output2 READ RdigitalOutput2 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool r_digital_output3 READ RdigitalOutput3 NOTIFY DigitalOutputsChanged)
    Q_PROPERTY(bool r_digital_output4 READ RdigitalOutput4 NOTIFY DigitalOutputsChanged)

    Q_PROPERTY(bool l_drive_enable_state READ LDriveEnableState NOTIFY DriveEnableStatesChanged)
    Q_PROPERTY(bool r_drive_enable_state READ RDriveEnableState NOTIFY DriveEnableStatesChanged)

    // BMS
    Q_PROPERTY(QString bmsState READ bmsState NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool air_plus READ airPlus NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool air_minus READ airMinus NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool precharge READ precharge NOTIFY bmsStatesChanged)
    Q_PROPERTY(bool imd_ok READ IMD_ok NOTIFY bmsStatesChanged)

    Q_PROPERTY(double bmsTotalCurrent READ bmsTotalCurrent NOTIFY bmsValuesChanged)
    Q_PROPERTY(double bmsTotalVoltage READ bmsTotalVoltage NOTIFY bmsValuesChanged)
    Q_PROPERTY(double battery_avg_temp READ battery_avg_temp NOTIFY bmsValuesChanged)

    Q_PROPERTY(double soc READ soc NOTIFY stateOfBatteryValuesChanged)
    Q_PROPERTY(double sop READ sop NOTIFY stateOfBatteryValuesChanged)
    Q_PROPERTY(double soh READ soh NOTIFY stateOfBatteryValuesChanged)

    Q_PROPERTY(QVector<double> ntcTemperature READ ntcTemperature NOTIFY NTC_TemperaturesChanged)

    Q_PROPERTY(QVector<double> voltageMin READ voltageMin NOTIFY bmsVoltagesChanged)
    Q_PROPERTY(QVector<double> voltageMax READ voltageMax NOTIFY bmsVoltagesChanged)

    Q_PROPERTY(QVector<double> temperatureMin READ temperatureMin NOTIFY bmsTempsChanged)
    Q_PROPERTY(QVector<double> temperatureAvg READ temperatureAvg NOTIFY bmsTempsChanged)
    Q_PROPERTY(QVector<double> temperatureMax READ temperatureMax NOTIFY bmsTempsChanged)




    Q_PROPERTY(double fault_count READ faultCount NOTIFY faultCountChanged)

public:
    explicit SignalHandler(QObject *parent = nullptr);

    //vcu
    double speed() const { return m_speed; }
    double slip() const {return m_slip;};
    double rpmL() const {return m_rpm_l;};
    double rpmR() const {return m_rpm_r;};
    double apps1() const {return m_apps[0];};
    double apps2() const {return m_apps[1];};
    double brakePressureForward() const {return m_brake_forward;};
    double brakePressureRear() const {return m_brake_rear;};
    double sw1() const {return m_sw_angle[0];};
    double sw2() const {return m_sw_angle[1];};
    double torqueL() const{return m_torque_l;};
    double torqueR() const{return m_torque_r;};
    double cFactor1() const {return m_c_factor1;};
    double cFactor2() const {return m_c_factor2;};
    double cFactor3() const {return m_c_factor3;};
    double cFactor4() const {return m_c_factor4;};
    QString mode() const {return m_mode;}
    QString preset() const {return m_preset;}
    QString vcuState() const {return m_vcu_state;};

    double accelerationX() const {return m_acceleration_x;};
    double accelerationY() const {return m_acceleration_y;};
    double accelerationZ() const {return m_acceleration_z;};
    double gyroZ() const {return m_gyro_z;};

    double vcuCurrent() const {return m_vcu_current;};

    //bms
    bool airPlus() const{return m_air_plus;};
    bool airMinus() const{return m_air_minus;};
    bool precharge() const{return m_precharge;};
    bool IMD_ok() const {return m_imd_ok;};
    QString bmsState() const {return m_bms_state;};

    double bmsTotalCurrent() const {return m_total_current;};
    double bmsTotalVoltage() const {return m_total_voltage;};
    double battery_avg_temp() const {
        double sum = 0;
        for(int i = 0; i < 6; i++) {
            sum += module_temperatures[i].sum;
        }
        return sum/6;
    };


    QVector<double> voltageMin() const;
    QVector<double> voltageMax() const;

    QVector<double> temperatureMin() const;
    QVector<double> temperatureAvg() const;
    QVector<double> temperatureMax() const;


    QVector<double> ntcTemperature() const;

    double sop() const {return m_sop;};
    double soc() const {return m_soc;}
    double soh() const {return m_soh;};

    //inverteri
    double motorTemperatureL() const {return m_motor_temperature_l;}
    double motorTemperatureR() const {return m_motor_temperature_r;}
    double inverterTemperatureL() const{return m_inverter_temperature_l;};
    double inverterTemperatureR() const{return m_inverter_temperature_r;};
    double ERPM_L() const {return m_erpm_l;};
    double ERPM_R() const {return m_erpm_r;};
    double AC_L() const {return m_ac_l;};
    double AC_R() const {return m_ac_r;};


    bool LdigitalOutput1() const {return m_digital_outputs_l[0];};
    bool LdigitalOutput2() const {return m_digital_outputs_l[1];};
    bool LdigitalOutput3() const {return m_digital_outputs_l[2];};
    bool LdigitalOutput4() const {return m_digital_outputs_l[3];};

    bool RdigitalOutput1() const {return m_digital_outputs_r[0];};
    bool RdigitalOutput2() const {return m_digital_outputs_r[1];};
    bool RdigitalOutput3() const {return m_digital_outputs_r[2];};
    bool RdigitalOutput4() const {return m_digital_outputs_r[3];};

    bool LDriveEnableState() const {return m_drive_enable_state_l;};
    bool RDriveEnableState() const {return m_drive_enable_state_r;};

    //
    int faultCount() const {return m_fault_count;};

public slots:
    void handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs, const QString &messageName);

signals:
    //vcu
    void speedChanged();
    void modeChanged();
    void presetChanged();
    void slipChanged();
    void rpmChanged();
    void brakePressureChanged();
    void swAngleChanged();
    void torqueChanged();
    void cFactorsChanged();
    void appsChanged();
    void vcuCurrentChanged();

    void vcuStateChanged();
    void imuValuesChanged();


    //bms
    void stateOfBatteryValuesChanged();
    void bmsStatesChanged();
    void bmsValuesChanged();
    void NTC_TemperaturesChanged();

    void bmsVoltagesChanged();
    void bmsTempsChanged();

    //inverter
    void motorTemperatureChanged();
    void inverterTemperatureChanged();
    void ERPMsChanged();
    void ACsChanged();
    void DriveEnableStatesChanged();
    void DigitalOutputsChanged();

    void faultCountChanged();



private:
    std::unordered_map<QString, std::function<void(const QVariant&)>> signal_map;

    //inverteri
    double m_erpm_l = -32768;
    double m_erpm_r = -32768;
    double m_ac_l = -300.0;
    double m_ac_r = -300.0;
    double m_inverter_temperature_l = 0.0;
    double m_inverter_temperature_r = 0.0;
    double m_motor_temperature_l = 0.0;
    double m_motor_temperature_r = 0.0;

    bool m_drive_enable_state_l = false;
    bool m_drive_enable_state_r = false;

    std::array<bool, 4> m_digital_outputs_l = {false, false, false, false};
    std::array<bool, 4> m_digital_outputs_r = {false, false, false, false};

    bool m_fault_code_l[8] = {false, false, false, false, false, false, false, false};
    bool m_fault_code_r[8] = {false, false, false, false, false, false, false, false};
    bool m_limit_bits_l[3] = {false, false, false};
    bool m_limit_bits_r[3] = {false, false, false};

    //bms
    bool m_air_plus = false;
    bool m_air_minus = false;
    bool m_precharge = false;
    bool m_imd_ok = false;
    QString m_bms_state = "default";

    double m_total_current = 0.0;
    double m_total_voltage = 0.0;

    double m_sop = 0.0;
    double m_soc = 0.0;
    double m_soh = 0.0;

    std::array<double, 2> m_ntc_temperatures = {0.0, 0.0};

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
            if(t < -20 || t > 80)
                return;

            min = std::min(min, t);
            max = std::max(max, t);
            sum += t;
            count++;
        }

        double avg() const {
            return count ? sum / count : 0;
        }

        void printStats() const {
            qDebug() << min << avg() << max;
        }


    };

    std::array<ValueStats, 6> module_temperatures;

    std::array<ValueStats, 6> module_voltages;



    //VCU početak
    double m_apps[2] = {0.0, 0.0};
    double m_brake_forward = 0.0;
    double m_brake_rear = 0.0;
    double m_sw_angle[2] = {0.0, 0.0};

    //int m_msg_count = 0;
    QString m_vcu_state = "default";
    uint16_t m_vcu_error_flags;
    uint8_t m_vcu_warnings;

    QString m_mode = "default";
    bool m_apps_plausibility = false;
    bool m_brake_plausibility = false;
    bool m_tc_active = false;
    bool m_brake_light = false;
    QString m_driver_selected_mode = "default"; //??



    double m_acceleration_x = 0.0;
    double m_acceleration_y = 0.0;
    double m_acceleration_z = 0.0;
    double m_gyro_z = 0.0;

    double m_c_factor1 = 0.0;
    double m_c_factor2 = 0.0;
    double m_c_factor3 = 0.0;
    double m_c_factor4 = 0.0;
    double m_c_factor5 = 0.0;

    double m_vcu_current = 0.0;

    double m_torque_l = 0.0;
    double m_torque_r = 0.0;

    double m_speed = 0.0;

    bool digitalInputs[16];// šta?

    QString m_preset = "default";

    double m_rpm_l = 0.0;// fali u dbc
    double m_rpm_r = 0.0;// fali u dbc
    double m_slip = 0.0; // fali u dbc

    // VCU kraj




    //mijenjat ce se ovo je za testiranje prikaza
    int m_fault_count = 3;
};

#endif // SIGNALHANDLER_H
