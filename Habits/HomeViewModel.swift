//
//  HomeViewModel.swift
//  Habits
//
//  Created by Eduard Ptushko on 17.02.2024.
//

import Foundation

@Observable
final class HomeViewModel {
    enum Section: Hashable {
        case leaderboard
        case followedUsers
    }

    enum Item: Hashable {
        case leaderboardHabit(name: String, leadingUserRanking: String?, secondaryUserRanking: String?)
        case followedUser(_ user: User, message: String)

        func hash(into hasher: inout Hasher) {
            switch self {
            case .leaderboardHabit(let name, _, _):
                hasher.combine(name)
            case .followedUser(let user, _):
                hasher.combine(user)
            }
        }

        static func ==(_ lhs: Item, _ rhs: Item) -> Bool {
            switch (lhs, rhs) {
            case (.leaderboardHabit(let lName, _, _), .leaderboardHabit(let rName, _, _)):
                return lName == rName
            case (.followedUser(let lUser, _), .followedUser(let rUser, _)):
                return lUser == rUser
            default:
                return false
            }
        }
    }

    struct Model {
        var usersByID = [String: User]()
        var habitsByName = [String: Habit]()
        var habitStatistics = [HabitStatistics]()
        var userStatistics = [UserStatistics]()

        var currentUser: User {
            Settings.shared.currentUser
        }

        var users: [User] {
            Array(usersByID.values)
        }

        var habits: [Habit] {
            Array(habitsByName.values)
        }

        var followedUsers: [User] {
            Array(usersByID.filter { Settings.shared.followedUserIDs.contains($0.key) }.values)
        }

        var favoriteHabits: [Habit] {
            Settings.shared.favoriteHabits
        }

        var nonFavoriteHabits: [Habit] {
            habits.filter { !favoriteHabits.contains($0) }
        }
    }

    var model = Model()

    func fetch() async {
        if let users = try? await UserRequest().send() {
            model.usersByID = users
        }

        if let habits = try? await HabitRequest().send() {
            model.habitsByName = habits
        }
    }

    func update() async {
        if let combinedStatistics = try? await CombinedStatisticsRequest().send() {
            model.userStatistics = combinedStatistics.userStatistics
            model.habitStatistics = combinedStatistics.habitStatistics
        } else {
            model.userStatistics = []
            model.habitStatistics = []
        }
    }
}
