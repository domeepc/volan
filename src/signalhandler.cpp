#include "signalhandler.h"

SignalHandler::SignalHandler(QObject *parent)
    : QObject{parent}
{
    // VCU signali
    signal_map["APPS1"] = [this](const QVariant &v){ m_apps[0] = v.toDouble(); emit appsChanged();};
    signal_map["APPS2"] = [this](const QVariant &v){ m_apps[1] = v.toDouble(); emit speedChanged();};

    signal_map["BrakePressure_F"] = [this](const QVariant &v){ m_brake_forward = v.toDouble(); emit brakePressureChanged();};
    signal_map["BrakePressure_R"] = [this](const QVariant &v){ m_brake_rear = v.toDouble(); emit brakePressureChanged();};

    signal_map["SteeringAngle1"] = [this](const QVariant &v){ m_sw_angle[0] = v.toDouble(); emit swAngleChanged();};
    signal_map["SteeringAngle2"] = [this](const QVariant &v){ m_sw_angle[1] = v.toDouble(); emit swAngleChanged();};

    //signal_map["MsgCnt"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    signal_map["VCU_StateID"] = [this](const QVariant &v){ m_vcu_state = v.toString(); emit vcuStateChanged();};
    //signal_map["VCU_ErrorFlags"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["VCU_Warnings"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};

    signal_map["ActiveDriveMode"] = [this](const QVariant &v){ m_mode = v.toString(); emit modeChanged();};
    //signal_map["APPS_Plausibility_OK"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["Brake_Plausibility_OK"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["TC_Active"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["BrakeLight"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["DriverSelected_Mode"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};

    signal_map["Accel_X"] = [this](const QVariant &v){ m_acceleration_x = v.toDouble(); emit speedChanged();};
    signal_map["Accel_Y"] = [this](const QVariant &v){ m_acceleration_y = v.toDouble(); emit speedChanged();};
    signal_map["Accel_Z"] = [this](const QVariant &v){ m_acceleration_z = v.toDouble(); emit speedChanged();};
    signal_map["Gyro_Z"] = [this](const QVariant &v){ m_gyro_z = v.toDouble(); emit speedChanged();};

    //signal_map["Corr_Factor_0"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["Corr_Factor_1"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["Corr_Factor_2"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["Corr_Factor_3"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    //signal_map["Corr_Factor_4"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};

    signal_map["VCU_Current"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    signal_map["LeftMotor_Torque"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    signal_map["RightMotor_Torque"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};
    signal_map["VehicleSpeed"] = [this](const QVariant &v){ m_speed = v.toDouble(); emit speedChanged();};

    //pdm



    // BMS status
    //komentirani signali trebaju ic na error handler
    signal_map["BMS_StateID"] = [this](const QVariant &v){m_bms_state = v.toString(); emit bmsStatesChanged();};
    //signal_map["BMS_ErrorFlags"] = [this](const QVariant &v){m_bms_state = v.toString(); emit bmsStatesChanged();};


    signal_map["AIR_Plus"] = [this](const QVariant &v){ m_air_plus = v.toBool(); emit bmsStatesChanged(); };
    signal_map["AIR_Minus"] = [this](const QVariant &v){ m_air_minus = v.toBool(); emit bmsStatesChanged(); };
    signal_map["Precharge_Relay"] = [this](const QVariant &v){ m_precharge = v.toBool(); emit bmsStatesChanged();};
    //signal_map["HV_Active"] = [this](const QVariant &v){ m_precharge = v.toBool(); emit bmsStatesChanged();};
    signal_map["IMD_OK"] = [this](const QVariant &v){ m_imd_ok = v.toBool(); emit bmsStatesChanged();};
    //signal_map["AMS_OK"] = [this](const QVariant &v){ m_imd_ok = v.toBool(); emit bmsStatesChanged();};
    //signal_map["BMS_Fault"] = [this](const QVariant &v){ m_imd_ok = v.toBool(); emit bmsStatesChanged();};

    signal_map["SOP"] = [this](const QVariant &v){ m_sop = v.toDouble(); emit stateOfBatteryValuesChanged();};
    signal_map["SOC"] = [this](const QVariant &v){ m_soc = v.toDouble(); emit stateOfBatteryValuesChanged();};
    signal_map["SOH"] = [this](const QVariant &v){ m_soh = v.toDouble(); emit stateOfBatteryValuesChanged();};
    signal_map["TotalCurrent"] = [this](const QVariant &v){ m_total_current = v.toDouble(); emit bmsValuesChanged();};

    // Lijevi inverter signali
    signal_map["L_Motor_Temp"] = [this](const QVariant &v){ m_motor_temperature_l = v.toDouble(); emit motorTemperatureChanged(); };
    signal_map["L_Ctrl_Temp"] = [this](const QVariant &v){ m_inverter_temperature_l = v.toDouble(); emit inverterTemperatureChanged(); };
    signal_map["L_AC_Current"] = [this](const QVariant &v){ m_ac_l = v.toDouble(); emit ACsChanged(); };
    signal_map["L_ERPM"] = [this](const QVariant &v){ m_erpm_l = v.toDouble(); emit ERPMsChanged(); };
    signal_map["L_Drive_Enable"] = [this](const QVariant &v){ m_drive_enable_state_l = v.toBool(); emit DriveEnableStatesChanged(); };
    signal_map["L_DigitalOutputs"] = [this](const QVariant &v){
        uint8_t raw = v.toUInt();
        for (int i = 0; i < 4; i++) {
            m_digital_outputs_l[i] = (raw >> i) & 1;
        }

        emit DigitalOutputsChanged();
    };

    signal_map["L_Limit_Bits"] = [this](const QVariant &v){
        uint8_t raw = v.toUInt();

        for (int i = 0; i < 3; i++) {
            m_limit_bits_l[i] = (raw >> i) & 1;
        }
        emit DigitalOutputsChanged();
    };
    signal_map["L_Fault_Code"] = [this](const QVariant &v){
        uint8_t raw = v.toUInt();

        for (int i = 0; i < 8; i++) {
            m_fault_code_l[i] = (raw >> i) & 1;
        }
        emit DigitalOutputsChanged();
    };


    // Desni inverter signali
    signal_map["R_Motor_Temp"] = [this](const QVariant &v){ m_motor_temperature_r = v.toDouble(); emit motorTemperatureChanged(); };
    signal_map["R_Ctrl_Temp"] = [this](const QVariant &v){ m_inverter_temperature_r = v.toDouble(); emit inverterTemperatureChanged(); };
    signal_map["R_AC_Current"] = [this](const QVariant &v){ m_ac_r = v.toDouble(); emit ACsChanged(); };
    signal_map["R_ERPM"] = [this](const QVariant &v){ m_erpm_r = v.toDouble(); emit ERPMsChanged(); };
    signal_map["R_Drive_Enable"] = [this](const QVariant &v){ m_drive_enable_state_r = v.toBool(); emit DriveEnableStatesChanged(); };
    signal_map["R_DigitalOutputs"] = [this](const QVariant &v){
        uint8_t raw = v.toUInt();
        for (int i = 0; i < 4; i++) {
            m_digital_outputs_r[i] = (raw >> (3 - i)) & 1;
        }
        qDebug() << "0 " << m_digital_outputs_r[0] << "1 " << m_digital_outputs_r[1] << "2 " << m_digital_outputs_r[2] << "3 " << m_digital_outputs_r[3];
        emit DigitalOutputsChanged();
    };

    signal_map["R_Limit_Bits"] = [this](const QVariant &v){
        uint8_t raw = v.toUInt();

        for (int i = 0; i < 3; i++) {
            m_limit_bits_r[i] = (raw >> (3 - i)) & 1;
        }
        emit DigitalOutputsChanged();
    };
    signal_map["R_Fault_Code"] = [this](const QVariant &v){
        uint8_t raw = v.toUInt();

        for (int i = 0; i < 8; i++) {
            m_fault_code_r[i] = (raw >> i) & 1;
        }
        emit DigitalOutputsChanged();
    };
}

void SignalHandler::handleDecodedFrame(QtCanBus::UniqueId id, const QMap<QString, QVariant> &sigs, const QString &messageName) {
    int moduleIndex;
    if (messageName.startsWith("BMS_Temp_M")) {
        QString numberPart = messageName.section('M', 2, 2).section('_', 0, 0);
        moduleIndex = numberPart.toInt()/2;
        //qDebug() << numberPart << " " << moduleIndex;


        if(module_temperatures[moduleIndex].messageCount == 2){
            emit bmsTempsChanged();
            module_temperatures[moduleIndex].reset();
        }

        for(auto it = sigs.begin(); it != sigs.end(); ++it) {
            if(it.key().startsWith("Temp_") && it.key() != "Temp_Group") {
                module_temperatures[moduleIndex].update(it.value().toDouble());
            }
        }

        module_temperatures[moduleIndex].printStats();
        module_temperatures[moduleIndex].messageCount++;
        return;

    }


    if(messageName.startsWith("BMS_Voltage_M")) {
        QString numberPart = messageName.section('M', 2, 2).section('_', 0, 0);
        moduleIndex = numberPart.toInt()/2;
        //qDebug() << numberPart << " " << moduleIndex;


        if(module_voltages[moduleIndex].messageCount == 2){
            emit bmsVoltagesChanged();
            module_voltages[moduleIndex].reset();
            module_voltages[moduleIndex].printStats();
        }


        for(auto it = sigs.begin(); it != sigs.end(); ++it) {
            if(it.key().startsWith("Cell_")) {
                module_voltages[moduleIndex].update(it.value().toDouble());
            }
        }

        module_voltages[moduleIndex].printStats();
        module_voltages[moduleIndex].messageCount++;

        //module_voltages[moduleIndex].printStats();
        return;
    }

    // svi ostali signali
    for(auto it = sigs.begin(); it != sigs.end(); ++it) {
        auto mapIt = signal_map.find(it.key());
        if(mapIt != signal_map.end())
        {
            mapIt->second(it.value());
        }
        else
        {
            qWarning() << "Unhandled signal:" << it.key();
        }
    }
}

QVector<double> SignalHandler::voltageMin() const {
    QVector<double> result;
    result.reserve(module_voltages.size());

    for(const auto &m : module_voltages)
        result.push_back(m.min);

    return result;
}

QVector<double> SignalHandler::voltageMax() const  {
    QVector<double> result;
    result.reserve(module_voltages.size());

    for(const auto &m : module_voltages)
        result.push_back(m.max);

    return result;
}

QVector<double> SignalHandler::temperatureMin() const {
    QVector<double> result;
    result.reserve(module_temperatures.size());

    for(const auto &m : module_temperatures)
        result.push_back(m.min);

    return result;
}

QVector<double> SignalHandler::temperatureAvg() const {
    QVector<double> result;
    result.reserve(module_temperatures.size());

    for(const auto &m : module_temperatures)
        result.push_back(m.avg());

    return result;
}

QVector<double> SignalHandler::temperatureMax() const {
    QVector<double> result;
    result.reserve(module_temperatures.size());

    for(const auto &m : module_temperatures)
        result.push_back(m.max);

    return result;
}

QVector<double> SignalHandler::ntcTemperature() const {
    QVector<double> result;
    result.reserve(m_ntc_temperatures.size());
    result.push_back(m_ntc_temperatures[0]);
    result.push_back(m_ntc_temperatures[1]);

    return result;
}

