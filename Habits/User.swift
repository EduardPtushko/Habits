//
//  User.swift
//  Habits
//
//  Created by Eduard Ptushko on 31.01.2024.
//

import Foundation

struct User {
    let id: String
    let name: String
    let color: CategoryColor?
    let bio: String?
}

extension User: Codable {}

extension User: Hashable {
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension User: Comparable {
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}
