//
//  HabitDetailViewModel.swift
//  Habits
//
//  Created by Eduard Ptushko on 05.02.2024.
//

import Foundation

@Observable
final class HabitDetailViewModel {
    var habitStatistics: HabitStatistics?
    var userCounts: [UserCount] {
        habitStatistics?.userCounts ?? []
    }

    func getHabitStats(habit: Habit) async {
        if let statistics = try? await HabitStatisticsRequest(habitNames: [habit.name]).send(), !statistics.isEmpty {
            habitStatistics = statistics[0]
        } else {
            habitStatistics = nil
        }
    }

    enum Section: Hashable {
        case leaders(count: Int)
        case remaining
    }

    enum Item: Hashable, Comparable {
        case single(_ stat: UserCount)
        case multiple(_ stats: [UserCount])

        static func <(_ lhs: Item, _ rhs: Item) -> Bool {
            switch (lhs, rhs) {
            case let (.single(lCount), .single(rCount)):
                return lCount.count < rCount.count
            case let (.multiple(lCounts), .multiple(rCounts)):
                return lCounts.first!.count < rCounts.first!.count
            case (.single, .multiple):
                return false
            case (.multiple, .single):
                return true
            }
        }
    }
}
