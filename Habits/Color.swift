//
//  Color.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import Foundation

struct CategoryColor {
    let hue: Double
    let saturation: Double
    let brightness: Double
}

extension CategoryColor: Codable {
    enum CodingKeys: String, CodingKey {
        case hue = "h"
        case saturation = "s"
        case brightness = "b"
    }
}
