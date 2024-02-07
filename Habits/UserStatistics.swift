//
//  UserStatistics.swift
//  Habits
//
//  Created by Eduard Ptushko on 07.02.2024.
//

import Foundation

struct UserStatistics {
    let user: User
    let habitCounts: [HabitCount]
}

extension UserStatistics: Codable {}
