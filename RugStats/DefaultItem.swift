//
//  DefaultActionPresetItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/24.
//

import Foundation

final class DefaultItem {
    
    public let defaultActionPresets: ActionPresetItem = ActionPresetItem(
        presetName: "Default",
        actions:[
            ActionLabelPresetItem(
                actionName: "Possession",
                labelSet: [
                    ActionLabelCategory(categoryName: "results", labels: [
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
                    ActionLabelCategory(categoryName: "types", labels: [
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
                    ActionLabelCategory(categoryName: "results", labels: [
                        "Won Outright",
                        "Won FK",
                        "Won PK",
                        "Reset",
                        "Lost Outright",
                        "Lost FK",
                        "Lost PK",
                        "Lost Reversed"
                    ]),
                    ActionLabelCategory(categoryName: "types", labels: [
                        "Positive",
                        "Neutral",
                        "Negative"
                    ])
                ]
            ),
            ActionLabelPresetItem(
                actionName: "Lineout",
                labelSet: [
                    ActionLabelCategory(categoryName: "results", labels: [
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
                    ActionLabelCategory(categoryName: "types", labels: [
                        "Front",
                        "Middle",
                        "Back"
                    ])
                ]
            ),
            ActionLabelPresetItem(
                actionName: "Kick",
                labelSet: [
                    ActionLabelCategory(categoryName: "results", labels: [
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
                    ActionLabelCategory(categoryName: "types", labels: [
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
                    ActionLabelCategory(categoryName: "results", labels: [
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
                    ActionLabelCategory(categoryName: "types", labels: [
                        "Offence",
                        "Defence"
                    ])
                ]
            ),
            ActionLabelPresetItem(
                actionName: "Try",
                labelSet: [
                    ActionLabelCategory(categoryName: "results", labels: [
                        "Conversion Success",
                        "Conversion Missed"
                    ]),
                    ActionLabelCategory(categoryName: "types", labels: [
                        "BK",
                        "FW"
                    ])
                ]
            ),
            ActionLabelPresetItem(
                actionName: "Shot at Goal",
                labelSet: [
                    ActionLabelCategory(categoryName: "results", labels: [
                        "Success",
                        "Missed"
                    ]),
                    ActionLabelCategory(categoryName: "types", labels: [])
                ]
            )
        ]
    )
    
}
