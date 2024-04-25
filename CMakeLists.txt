cmake_minimum_required(VERSION 3.14)

project(quick_demo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(WIN32)
    set(CMAKE_PREFIX_PATH "C:/Qt/5.15.2/mingw81_64/lib/cmake")
elseif(UNIX)
    set(CMAKE_PREFIX_PATH "/opt/Qt/5.15.2/gcc_64/lib/cmake")
else()
    message("This is neither Windows nor UNIX platform")
endif()



find_package(QT NAMES Qt5 REQUIRED COMPONENTS Core Quick Qml Widgets Multimedia)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Qml Widgets Multimedia)

set(PROJECT_SOURCES
        main.cpp
        qml.qrc
        third_device.h
        tdlas_device.cpp
        tdlas_device.h
        camera.h
)

add_executable(quick_demo
        ${PROJECT_SOURCES}
        custom_video_surface.h
        custom_video_surface.cpp
        frame_provider.h frame_provider.cpp
        video_dlg.h
)

target_link_libraries(quick_demo PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Qml Qt${QT_VERSION_MAJOR}::Widgets Qt5::Multimedia)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if (${QT_VERSION} VERSION_LESS 6.1.0)
    set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.quick_demo)
endif ()
set_target_properties(quick_demo PROPERTIES
        ${BUNDLE_ID_OPTION}
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS quick_demo
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if (QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(quick_demo)
    qt_finalize_executable(quick_demo)
endif ()
