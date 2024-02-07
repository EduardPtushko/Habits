//
//  HabitCount.swift
//  Habits
//
//  Created by Eduard Ptushko on 07.02.2024.
//

import Foundation

struct HabitCount {
    let habit: Habit
    let count: Int
}

extension HabitCount: Codable {}

extension HabitCount: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(habit)
    }

    static func ==(_ lhs: HabitCount, _ rhs: HabitCount) -> Bool {
        lhs.habit == rhs.habit
    }
}

extension HabitCount: Comparable {
    static func <(lhs: HabitCount, rhs: HabitCount) -> Bool {
        lhs.habit < rhs.habit
    }
}
