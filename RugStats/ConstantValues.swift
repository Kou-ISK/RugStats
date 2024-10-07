//
//  ConstantValues.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/07.
//

import Foundation

// ローカライズされたアクション名のリスト
public var actionList: [String] {
    return [
        NSLocalizedString("スクラム", comment: "Action: Scrum"),
        NSLocalizedString("ラインアウト", comment: "Action: Lineout"),
        NSLocalizedString("ペナルティ", comment: "Action: Penalty"),
        NSLocalizedString("トライ", comment: "Action: Try"),
        NSLocalizedString("コンバージョンG", comment: "Action: Conversion"),
        NSLocalizedString("PG", comment: "Action: PG"),
        NSLocalizedString("DG", comment: "Action: DG")
    ]
}

public var zoneList: [String] {
    return [
        NSLocalizedString("Opp22m-GL", comment: "Zone: Opp22m-GL"),
        NSLocalizedString("Halfway-Opp22m", comment: "Zone: Halfway-Opp22m"),
        NSLocalizedString("22m-Halfway", comment: "Zone: 22m-Halfway"),
        NSLocalizedString("GL-22m", comment: "Zone: GL-22m")
    ]
}

public var laneList: [String] {
    return [
        NSLocalizedString("Left", comment: "Lane: Left"),
        NSLocalizedString("Mid-Left", comment: "Lane: Mid-Left"),
        NSLocalizedString("Middle", comment: "Lane: Middle"),
        NSLocalizedString("Mid-Right", comment: "Lane: Mid-Right"),
        NSLocalizedString("Right", comment: "Lane: Right")
    ]
}
