/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-CLA-applies
 *
 * MuseScore
 * Music Composition & Notation
 *
 * Copyright (C) 2021 MuseScore BVBA and others
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
import QtQuick 2.15
import QtQuick.Layouts 1.15

import MuseScore.Ui 1.0
import MuseScore.UiComponents 1.0
import MuseScore.AppShell 1.0

StyledDialogView {
    id: root

    title: qsTrc("appshell/about", "About MuseScore")

    contentHeight: 424
    contentWidth: 480

    AboutModel {
        id: aboutModel
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 30

        ColumnLayout {
            id: content

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 36
            Layout.leftMargin: 40
            Layout.rightMargin: 40

            spacing: 32

            Image {
                id: logo
                Layout.alignment: Qt.AlignHCenter

                source: "qrc:/qml/resources/mu_logo.svg"
                sourceSize: Qt.size(100, 100)
            }

            Column {
                spacing: 8
                Layout.fillWidth: true

                StyledTextLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTrc("appshell/about", "Version:") + " " + aboutModel.museScoreVersion()
                    font: ui.theme.bodyBoldFont
                }

                Row {
                    spacing: 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    StyledTextLabel {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTrc("appshell/about", "Revision:") + " " + aboutModel.museScoreRevision()
                    }

                    FlatButton {
                        anchors.verticalCenter: parent.verticalCenter
                        icon: IconCode.COPY

                        onClicked: {
                            aboutModel.copyRevisionToClipboard()
                        }
                    }
                }
            }

            StyledTextLabel {
                Layout.fillWidth: true
                text: {
                    let museScoreUrl = aboutModel.museScoreUrl()

                    //: %1 will be a link to the MuseScore website
                    let line1 = qsTrc("appshell/about", "Visit %1 for new versions and more information.")
                                .arg(`<a href="${museScoreUrl.url}">${museScoreUrl.displayName}</a>`)

                    //: The text between %1 and %2 will be a clickable link (same for %3 and %4)
                    let line2 = qsTrc("appshell/about", "Get %1help%2 with the program or %3contribute%4 to its development.")
                                .arg(`<a href="${aboutModel.museScoreForumUrl().url}">`).arg("</a>")
                                .arg(`<a href="${aboutModel.museScoreContributionUrl().url}">`).arg("</a>")

                    return line1 + "<br>" + line2
                }
                wrapMode: Text.WordWrap
                maximumLineCount: 3
            }

            StyledTextLabel {
                Layout.fillWidth: true

                //: The text between %1 and %2 will be a clickable link
                text: qsTrc("appshell/about", "For privacy information, see our %1privacy policy%2.")
                      .arg(`<a href="${aboutModel.museScorePrivacyPolicyUrl().url}">`).arg("</a>")

                wrapMode: Text.WordWrap
                maximumLineCount: 3
            }

            StyledTextLabel {
                Layout.fillWidth: true
                text: {
                    //: The text between %1 and %2 will be a clickable link
                    var message = qsTrc("appshell/about", "Copyright © 1999-2022 MuseScore BVBA and others.\nPublished under the %1GNU General Public License version 3%2.")
                    return message
                    .arg("<a href='https://www.gnu.org/licenses/gpl-3.0.html'>")
                    .arg("</a>")
                    .replace("\n", "<br>")
                }

                wrapMode: Text.WordWrap
                maximumLineCount: 3
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 16
            Layout.bottomMargin: 16

            spacing: 12

            FlatButton {
                text: qsTrc("global", "OK")

                onClicked: {
                    root.hide()
                }
            }
        }
    }
}
