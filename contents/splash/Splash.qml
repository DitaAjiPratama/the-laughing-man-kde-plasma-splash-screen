/*
 *  MIT License
 *
 *  Copyright (c) 2019 Dita Aji Pratama
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

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
