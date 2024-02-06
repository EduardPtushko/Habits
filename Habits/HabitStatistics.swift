//
//  HabitStatistics.swift
//  Habits
//
//  Created by Eduard Ptushko on 05.02.2024.
//

import Foundation

struct HabitStatistics {
    let habit: Habit
    let userCounts: [UserCount]
}

extension HabitStatistics: Codable {}
