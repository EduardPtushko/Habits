//
//  APIService.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import Foundation
import SwiftUI

struct HabitRequest: APIRequest {
    typealias Response = [String: Habit]

    var habitName: String?

    var path: String { "/habits" }
}

struct UserRequest: APIRequest {
    typealias Response = [String: User]

    var path: String { "/users" }
}

struct HabitStatisticsRequest: APIRequest {
    typealias Response = [HabitStatistics]

    var habitNames: [String]?

    var path: String { "/habitStats" }

    var queryItems: [URLQueryItem]? {
        if let habitNames {
            return [URLQueryItem(name: "names", value: habitNames.joined(separator: ","))]
        } else {
            return nil
        }
    }
}

struct UserStatisticsRequest: APIRequest {
    typealias Response = [UserStatistics]

    var userIDs: [String]?

    var path: String { "/userStats" }

    var queryItems: [URLQueryItem]? {
        if let userIDs {
            return [URLQueryItem(name: "ids", value: userIDs.joined(separator: ","))]
        } else {
            return nil
        }
    }
}

struct HabitLeadStatisticsRequest: APIRequest {
    typealias Response = UserStatistics

    var userID: String

    var path: String { "/userLeadingStats/\(userID)" }
}

struct ImageRequest: APIRequest {
    typealias Response = UIImage

    var imageID: String

    var path: String { "/images/" + imageID }

    var imageURL: URL? {
        request.url
    }
}
