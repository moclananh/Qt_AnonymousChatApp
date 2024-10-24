cmake_minimum_required(VERSION 3.16)

project(Project_AnonymousChat VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appProject_AnonymousChat
    main.cpp
)

qt_add_qml_module(appProject_AnonymousChat
    URI Project_AnonymousChat
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES MyIcon.qml
        QML_FILES ImageRounded.qml
        RESOURCES Resources.qrc
        QML_FILES CustomDrawer.qml
        QML_FILES LandingChat.qml
        QML_FILES CreateChatRoom.qml
        QML_FILES MyButton.qml
        QML_FILES JoinChatRoom.qml
        QML_FILES LoadingPage.qml
        QML_FILES HomeScreen.qml
        QML_FILES ChatSession.qml
        QML_FILES ChatContent.qml
        QML_FILES ChatServices.js
        RESOURCES
        QML_FILES ThemeSettings.qml


)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appProject_AnonymousChat PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appProject_AnonymousChat
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appProject_AnonymousChat
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appProject_AnonymousChat
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
