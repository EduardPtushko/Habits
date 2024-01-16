//
//  APIService.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import Foundation

struct HabitRequest: APIRequest {
    typealias Response = [String: Habit]

    let habitName: String?

    var path: String { "/habits" }
}
