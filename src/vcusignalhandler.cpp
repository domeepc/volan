#include "vcusignalhandler.h"

VcuSignalHandler::VcuSignalHandler(QObject* parent)
    : QObject(parent)
{
    // APPS
    signal_map["APPS1"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_apps1 != val) {
            m_apps1 = val;
            emit appsChanged();
        }
    };

    signal_map["APPS2"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_apps2 != val) {
            m_apps2 = val;
            emit appsChanged();
        }
    };

    // BRAKE
    signal_map["BrakePressure_F"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_brake_forward != val) {
            m_brake_forward = val;
            emit brakePressureChanged();
        }
    };

    signal_map["BrakePressure_R"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_brake_rear != val) {
            m_brake_rear = val;
            emit brakePressureChanged();
        }
    };

    // STEERING
    signal_map["SteeringAngle1"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_sw_angle1 != val) {
            m_sw_angle1 = val;
            emit swAngleChanged();
        }
    };

    signal_map["SteeringAngle2"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_sw_angle2 != val) {
            m_sw_angle2 = val;
            emit swAngleChanged();
        }
    };

    // STATE / MODE
    signal_map["VCU_StateID"] = [this](const QVariant &v){
        QString val = v.toString();
        if (m_state != val) {
            m_state = val;
            emit stateChanged();
        }
    };

    signal_map["ActiveDriveMode"] = [this](const QVariant &v){
        QString val = v.toString();
        if (m_mode != val) {
            m_mode = val;
            emit modeChanged();
        }
    };

    // SPEED
    signal_map["VehicleSpeed"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_speed != val) {
            m_speed = val;
            emit speedChanged();
        }
    };

    // SLIP
    signal_map["Slip"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_slip != val) {
            m_slip = val;
            emit slipChanged();
        }
    };

    // CURRENT
    signal_map["VCU_Current"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_current != val) {
            m_current = val;
            emit currentChanged();
        }
    };

    // TORQUE
    signal_map["LeftMotor_Torque"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_torque_l != val) {
            m_torque_l = val;
            emit torqueChanged();
        }
    };

    signal_map["RightMotor_Torque"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_torque_r != val) {
            m_torque_r = val;
            emit torqueChanged();
        }
    };

    // IMU
    signal_map["Accel_X"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_acceleration_x != val) {
            m_acceleration_x = val;
            emit imuChanged();
        }
    };

    signal_map["Accel_Y"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_acceleration_y != val) {
            m_acceleration_y = val;
            emit imuChanged();
        }
    };

    signal_map["Accel_Z"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_acceleration_z != val) {
            m_acceleration_z = val;
            emit imuChanged();
        }
    };

    signal_map["Gyro_Z"] = [this](const QVariant &v){
        double val = v.toDouble();
        if (m_gyro_z != val) {
            m_gyro_z = val;
            emit imuChanged();
        }
    };
}

void VcuSignalHandler::processSignal(const QString& name, const QVariant& value, const QString &messageName)
{
    auto it = signal_map.find(name);
    if (it != signal_map.end()) {
        it->second(value);
    }
}

// QVector<double> VcuSignalHandler::cfactors () const {

//     return ;
// }
