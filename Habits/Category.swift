//
//  Category.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import Foundation
import SwiftUI

struct Category {
    let name: String
    let color: CategoryColor
}

extension Category: Codable {}

extension Category: Hashable {
    static func ==(lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
