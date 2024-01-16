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
