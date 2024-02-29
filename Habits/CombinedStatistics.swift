//
//  CombinedStatistics.swift
//  Habits
//
//  Created by Eduard Ptushko on 17.02.2024.
//

import Foundation

struct CombinedStatistics {
    let userStatistics: [UserStatistics]
    let habitStatistics: [HabitStatistics]
}

extension CombinedStatistics: Codable {}
