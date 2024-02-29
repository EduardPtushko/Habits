//
//  LoggedHabit.swift
//  Habits
//
//  Created by Eduard Ptushko on 14.02.2024.
//

import Foundation

struct LoggedHabit {
    let userID: String
    let habitName: String
    let timestamp: Date
}

extension LoggedHabit: Codable {}
