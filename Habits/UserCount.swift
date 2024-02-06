//
//  UserCount.swift
//  Habits
//
//  Created by Eduard Ptushko on 05.02.2024.
//

import Foundation

struct UserCount {
    let user: User
    let count: Int
}

extension UserCount: Codable {}

extension UserCount: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
    }

    static func ==(_ lhs: UserCount, _ rhs: UserCount) -> Bool {
        lhs.user == rhs.user
    }
}
