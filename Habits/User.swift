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
    static func ==(_ lhs: User, _ rhs: User) -> Bool {
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

#if DEBUG
extension User {
    static var sampleUser = User(
        id: "user1",
        name: "Amber Spiers",
        color: CategoryColor(
            hue: 0.382,
            saturation: 0.985,
            brightness: 0.976
        ),
        bio: "Fascinated by soccer since I was in diapers. Self-motivated. My guiding principles: I care and I'm thoughtful."
    )
}
#endif
