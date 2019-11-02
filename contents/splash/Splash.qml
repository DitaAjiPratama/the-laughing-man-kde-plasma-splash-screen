import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {
    id: root
    source: "images/black.jpg"
    fillMode: Image.PreserveAspectCrop
    
    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }


        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 50
            opacity: 1
            anchors.centerIn: parent

            source: "images/bluewhite.png"

            sourceSize.width: size
            sourceSize.height: size
        }
        
        FontLoader {
         source: "../components/artwork/fonts/OpenSans-Light.ttf"
        }

//         Text {
//             id: date
//             text:Qt.formatDateTime(new Date(),"dddd, hh:mm A")
//             font.pointSize: 30
//             color: "#006A80"
//             opacity:0.85
//             font { family: "OpenSans Light"; weight: Font.Light ;capitalization: Font.Capitalize}
//             anchors.horizontalCenter: parent.horizontalCenter
//             y: (parent.height - height) / 1.1
//         }

        Image {
            id: busyIndicator1
            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
//             y: root.height - (root.height - logo.y) / 1.9 - height/2
            anchors.verticalCenter: logo.verticalCenter
            anchors.left: logo.left
            source: "images/circular-roll.png"
            opacity: 1
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 13
            sourceSize.height: size
            sourceSize.width: size
            RotationAnimator on rotation {
                id: rotationAnimator1
                from: 360
                to: 0
                duration: 6000
                loops: Animation.Infinite
            }
        }
        
        Image {
            id: cap
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 50
            opacity: 1
            anchors.centerIn: parent

            source: "images/cap.png"

            sourceSize.width: size
            sourceSize.height: size
        }
        
        Image {
            id: busyIndicator2
            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.9 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget4.svg"
            opacity: 0.9
            sourceSize.height: units.gridUnit * 4.6
            sourceSize.width: units.gridUnit * 4.6
            RotationAnimator on rotation {
                id: rotationAnimator2
                from: 0
                to: 360
                duration: 1100
                loops: Animation.Infinite
            }
        }
        
        
//         Row {
//             spacing: units.smallSpacing*2
//             anchors {
//                 bottom: parent.bottom
//                 right: parent.right
//                 rightMargin: units.gridUnit * 1.5
//                 margins: units.gridUnit
//             }
//             Image {
//                 source: "images/KDE_Plasma_5_banner.png"
//                 sourceSize.height: units.gridUnit * 10
//                 sourceSize.width: units.gridUnit * 10
//             }
//         }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
}
