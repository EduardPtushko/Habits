//
//  UserViewModel.swift
//  Habits
//
//  Created by Eduard Ptushko on 31.01.2024.
//

import Foundation

@Observable
final class UserViewModel {
    var usersByID = [String: User]()
    var followedUsers: [User] {
        Array(usersByID.filter { Settings.shared.followedUserIDs.contains($0.key) }.values)
    }

    var users: [Item] = []

    func setUsers() {
        users = usersByID.values.sorted().reduce(into: [Item]()) { partial, user in
            partial.append(Item(user: user, isFollowed: followedUsers.contains(user)))
        }
    }

    func update() async {
        if let users = try? await UserRequest().send() {
            usersByID = users
        } else {
            usersByID = [:]
        }
        setUsers()
    }

    struct Item: Hashable {
        let user: User
        let isFollowed: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(user)
        }

        static func ==(_ lhs: Item, _ rhs: Item) -> Bool {
            lhs.user == rhs.user
        }
    }
}
