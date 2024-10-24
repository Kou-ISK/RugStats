//
//  ColorItem.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/08.
//

import Foundation
import SwiftData

@Model
final class ColorItem{
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}
