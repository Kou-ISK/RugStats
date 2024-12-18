//
//  DefaultActionPresetItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/24.
//

import Foundation

final class DefaultItem {
    
    public let defaultActionPresets: [ActionPresetItem] = [
        ActionPresetItem(
            presetName: "Default",
            actions:[
                ActionLabelPresetItem(
                    actionName: "Possession",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Try",
                            "Drop Goal",
                            "Kick Out of Play",
                            "Kick Error",
                            "Kick in Play",
                            "Pen Won",
                            "Scrum",
                            "Pen Con",
                            "Turnover",
                            "Turnover (Scrum)",
                            "Own Lineout",
                            "Other",
                            "End of Play"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "50m Restart",
                            "50m Restart Retained",
                            "22m Restart",
                            "22m Restart Retained",
                            "Goal Line Restart",
                            "Goal Line Restart Retained",
                            "Kick Return",
                            "Quick Tap",
                            "Turnover Won",
                            "Lineout",
                            "Lineout Steal",
                            "Scrum",
                            "Scrum Steal"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "Scrum",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Won Outright",
                            "Won FK",
                            "Won PK",
                            "Reset",
                            "Lost Outright",
                            "Lost FK",
                            "Lost PK",
                            "Lost Reversed"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "Positive",
                            "Neutral",
                            "Negative"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "Lineout",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Won",
                            "Won & Maul",
                            "Won Tap",
                            "Won FK",
                            "Won PK",
                            "Lost Throwing Error",
                            "Lost Catching / Delivery Error",
                            "Lost",
                            "Lost FK",
                            "Lost PK"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "Front",
                            "Middle",
                            "Back"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "Kick",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Touch(Bounce)",
                            "Touch(Full)",
                            "Error",
                            "Caught Full",
                            "Collected Bounce",
                            "In Goal",
                            "Own Player - Collected",
                            "Own Player - Failed",
                            "Pressure in Touch",
                            "Pressure Carried Over",
                            "Pressure Error",
                            "Try Kick"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "Bomb",
                            "Chip",
                            "Cross Pitch",
                            "Territorial",
                            "Low",
                            "Box",
                            "Touch Kick"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "PK",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Not Releasing",
                            "Not Rolling Away",
                            "Off Feet at Ruck",
                            "Hands in Ruck",
                            "Wrong Side at Ruck",
                            "Wrong Side at Maul",
                            "Collapsing Maul",
                            "Offside",
                            "Offside at Kick",
                            "Deliberate Knock On",
                            "Obstruction",
                            "Foul Play",
                            "Scrum",
                            "Lineout",
                            "Other Offence"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "Offence",
                            "Defence"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "Try",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Conversion Success",
                            "Conversion Missed"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "BK",
                            "FW"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "Goal Kick",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Success",
                            "Missed"
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "Penalty Goal",
                            "Drop Goal"
                        ])
                    ]
                )
            ]
        ),
        /*
         個人スタッツ用デフォルトプリセット
         */
        ActionPresetItem(
            presetName: "Default Individual",
            actions:[
                ActionLabelPresetItem(
                    actionName: "Tackle",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Dominant",
                            "Neutral",
                            "Ineffective",
                            "Missed"
                        ]),
                        ActionLabelCategory(categoryName: "Qualifiers", labels: [
                            "Assist",
                        ]),
                        ActionLabelCategory(categoryName: "Types", labels: [
                            "Line Tackle",
                            "Edge Tackle",
                            "Guard Tackle",
                            "Chase Tackle",
                            "Cover Tackle",
                            "Other Tackle",
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "AT Ruck OOA",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Order", labels: [
                            "1st",
                            "2nd",
                            "3rd+"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "DF Ruck OOA",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Order", labels: [
                            "1st",
                            "2nd",
                            "3rd+"
                        ]),
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Turnover Won",
                            "Pen Won"
                        ])
                    ]
                ),
                ActionLabelPresetItem(
                    actionName: "Ball Carry",
                    labelSet: [
                        ActionLabelCategory(categoryName: "Results", labels: [
                            "Tackled Ineffectiv",
                            "Tackled Neutral",
                            "Tackled Dominant",
                            "Try Scored",
                            "Error",
                            "Kick",
                            "Pass",
                            "Off Load",
                        ]),
                        ActionLabelCategory(categoryName: "Gain line", labels: [
                            "Crossed",
                            "Neutral",
                            "Failed"
                        ])
                    ]
                )
            ]
        )
    ]
    
}
