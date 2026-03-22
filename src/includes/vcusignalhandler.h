#ifndef VCUSIGNALHANDLER_H
#define VCUSIGNALHANDLER_H

#include <QObject>
#include <QString>
#include <QVariant>
#include <unordered_map>
#include <functional>
#include <array>

class VcuSignalHandler : public QObject
{
    Q_OBJECT

    // CORE
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(double slip READ slip NOTIFY slipChanged)
    Q_PROPERTY(QString mode READ mode NOTIFY modeChanged)
    Q_PROPERTY(QString state READ state NOTIFY stateChanged)
    Q_PROPERTY(QString preset READ preset NOTIFY presetChanged)

    // INPUTS
    Q_PROPERTY(double apps1 READ apps1 NOTIFY appsChanged)
    Q_PROPERTY(double apps2 READ apps2 NOTIFY appsChanged)

    Q_PROPERTY(double brakePressureForward READ brakePressureForward NOTIFY brakePressureChanged)
    Q_PROPERTY(double brakePressureRear READ brakePressureRear NOTIFY brakePressureChanged)

    Q_PROPERTY(double swAngle1 READ swAngle1 NOTIFY swAngleChanged)
    Q_PROPERTY(double swAngle2 READ swAngle2 NOTIFY swAngleChanged)

    // TORQUE / CURRENT
    Q_PROPERTY(double torqueL READ torqueL NOTIFY torqueChanged)
    Q_PROPERTY(double torqueR READ torqueR NOTIFY torqueChanged)
    Q_PROPERTY(double current READ current NOTIFY currentChanged)
    Q_PROPERTY(double rpmL READ rpmL NOTIFY rpmChanged)
    Q_PROPERTY(double rpmR READ rpmR NOTIFY rpmChanged)

    // IMU
    Q_PROPERTY(double accelerationX READ accelerationX NOTIFY imuChanged)
    Q_PROPERTY(double accelerationY READ accelerationY NOTIFY imuChanged)
    Q_PROPERTY(double accelerationZ READ accelerationZ NOTIFY imuChanged)
    Q_PROPERTY(double gyroZ READ gyroZ NOTIFY imuChanged)

    //Q_PROPERTY(QVector<double> cfactors READ cfactors NOTIFY cfactorsChanged)

public:
    explicit VcuSignalHandler(QObject* parent = nullptr);

    // getters
    double speed() const { return m_speed; }
    double slip() const { return m_slip; }
    QString mode() const { return m_mode; }
    QString state() const { return m_state; }
    QString preset() const { return m_preset; }

    double apps1() const { return m_apps1; }
    double apps2() const { return m_apps2; }

    double brakePressureForward() const { return m_brake_forward; }
    double brakePressureRear() const { return m_brake_rear; }

    double swAngle1() const { return m_sw_angle1; }
    double swAngle2() const { return m_sw_angle2; }

    double torqueL() const { return m_torque_l; }
    double torqueR() const { return m_torque_r; }
    double rpmL() const { return m_rpm_l;}
    double rpmR() const {return m_rpm_r;}

    double current() const { return m_current; }

    double accelerationX() const { return m_acceleration_x; }
    double accelerationY() const { return m_acceleration_y; }
    double accelerationZ() const { return m_acceleration_z; }
    double gyroZ() const { return m_gyro_z; }

    //QVector<double> cfactors() const;

signals:
    void speedChanged();
    void slipChanged();
    void modeChanged();
    void stateChanged();
    void presetChanged();

    void cfactorsChanged();

    void appsChanged();
    void brakePressureChanged();
    void swAngleChanged();

    void torqueChanged();
    void currentChanged();
    void rpmChanged();

    void imuChanged();

public slots:
    void processSignal(const QString& name, const QVariant& value, const QString &messageName);

private:
    std::unordered_map<QString, std::function<void(const QVariant&)>> signal_map;

    // APPS
    double m_apps1 = 0.0;
    double m_apps2 = 0.0;

    // brake
    double m_brake_forward = 0.0;
    double m_brake_rear = 0.0;

    // steering
    double m_sw_angle1 = 0.0;
    double m_sw_angle2 = 0.0;

    // states
    QString m_state = "default";
    QString m_mode = "default";
    QString m_driver_selected_mode = "default";
    QString m_preset = "default";

    // factors
    std::array<double, 5> m_cfactors = {};

    // errors
    uint16_t m_error_flags = 0;
    uint8_t m_warnings = 0;

    // digital
    bool m_apps_plausibility = false;
    bool m_brake_plausibility = false;
    bool m_tc_active = false;
    bool m_brake_light = false;
    bool digitalInputs[16] = {false};

    // IMU
    double m_acceleration_x = 0.0;
    double m_acceleration_y = 0.0;
    double m_acceleration_z = 0.0;
    double m_gyro_z = 0.0;

    // power
    double m_current = 0.0;
    double m_torque_l = 0.0;
    double m_torque_r = 0.0;

    // motion
    double m_speed = 0.0;
    double m_rpm_l = 0.0;
    double m_rpm_r = 0.0;
    double m_slip = 0.0;
};

#endif // VCUSIGNALHANDLER_H
