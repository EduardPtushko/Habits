//
//  UserDetailViewModel.swift
//  Habits
//
//  Created by Eduard Ptushko on 07.02.2024.
//

import Foundation

@Observable
final class UserDetailViewModel {
    var userStats: UserStatistics?
    var leadingStats: UserStatistics?

    func update(user: User) async {
        if let userStats = try? await UserStatisticsRequest(userIDs: [user.id]).send(), !userStats.isEmpty {
            self.userStats = userStats[0]
        } else {
            userStats = nil
        }

        if let userStats = try? await HabitLeadStatisticsRequest(userID: user.id).send() {
            leadingStats = userStats
        } else {
            leadingStats = nil
        }
    }

    enum Section: Hashable, Comparable {
        case leading
        case category(_ category: Category)

        static func <(lhs: Section, rhs: Section) -> Bool {
            switch (lhs, rhs) {
            case (.leading, .category), (.leading, .leading):
                return true
            case (.category, .leading):
                return false
            case (category(let category1), category(let category2)):
                return category1.name > category2.name
            }
        }
    }

    typealias Item = HabitCount
}
