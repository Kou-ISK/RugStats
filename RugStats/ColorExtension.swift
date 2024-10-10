//
//  ColorExtension.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/10.
//

import SwiftUI

extension Color {
    func toRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        // UIColor に変換
        let uiColor = UIColor(self)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // RGB 色空間かどうかを確認
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        return (red, green, blue, alpha)
    }
}
