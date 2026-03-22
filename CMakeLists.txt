cmake_minimum_required(VERSION 3.16)

project(volan VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick SerialBus SerialPort)

qt_standard_project_setup()

qt_add_executable(appvolan
    src/main.cpp
)

qt_policy(SET QTP0001 NEW)

qt_add_qml_module(appvolan
    URI volan
    VERSION 1.0
    QML_FILES
        src/design/Main.qml
        src/design/test.qml
        src/views/raceView.qml
        src/views/mechView.qml
        src/views/bmsView.qml
        src/views/vcuView.qml
        src/views/errorView.qml
        src/views/inverterView.qml
        src/views/wheelDebugView.qml
        src/views/testView.qml
        src/components/BatteryBar.qml
        src/components/SpeedGauge.qml
        src/components/DataTile.qml
        src/components/ValueRow.qml
        src/components/TitleTile.qml
    SOURCES
        src/includes/caninterface.h       src/caninterface.cpp
        src/includes/canmessageprocessor.h src/canmessageprocessor.cpp
        src/includes/dbcmanager.h          src/dbcmanager.cpp
        src/includes/signalhandler.h       src/signalhandler.cpp
        src/includes/bmssignalhandler.h    src/bmssignalhandler.cpp
        src/includes/vcusignalhandler.h    src/vcusignalhandler.cpp
        src/includes/invertersignalhandler.h src/invertersignalhandler.cpp

)

target_include_directories(appvolan PRIVATE src/includes)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appvolan PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appvolan
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appvolan
    PRIVATE Qt6::Quick
    PRIVATE Qt6::SerialBus
    PRIVATE Qt6::SerialPort
)

include(GNUInstallDirs)
install(TARGETS appvolan
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
