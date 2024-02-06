//
//  Habit.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import Foundation

struct Habit {
    let name: String
    let category: Category
    let info: String
}

extension Habit: Codable {}

extension Habit: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func ==(_ lhs: Habit, _ rhs: Habit) -> Bool {
        lhs.name == rhs.name
    }
}

extension Habit: Comparable {
    static func <(lhs: Habit, rhs: Habit) -> Bool {
        lhs.name < rhs.name
    }
}

#if DEBUG
extension Habit {
    static var sampleHabit = Habit(
        name: "Brisk walk",
        category: Category(
            name: "Exercise",
            color: CategoryColor(
                hue: 0.25,
                saturation: 1,
                brightness: 0.9
            )
        ),
        info: "Get your heart rate up with this simple aerobic exercise."
    )
}
#endif
