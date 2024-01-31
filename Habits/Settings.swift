//
//  Settings.swift
//  Habits
//
//  Created by Eduard Ptushko on 29.01.2024.
//

import Foundation

struct Settings {
    static var shared = Settings()

    private let defaults = UserDefaults.standard

    private func archiveJSON(value: some Encodable, key: String) {
        let data = try! JSONEncoder().encode(value)
        let string = String(data: data, encoding: .utf8)
        defaults.set(string, forKey: key)
    }

    private func unarchiveJSON<T: Decodable>(key: String) -> T? {
        guard let string = defaults.string(forKey: key), let data = string.data(using: .utf8) else { return nil }
        return try! JSONDecoder().decode(T.self, from: data)
    }

    var favoriteHabits: [Habit] {
        get {
            unarchiveJSON(key: Setting.favoriteHabits) ?? []
        }
        set {
            archiveJSON(value: newValue, key: Setting.favoriteHabits)
        }
    }

    mutating func toggleFavorites(habit: Habit) {
        var favorites = favoriteHabits

        if favorites.contains(habit) {
            favorites = favorites.filter { $0 != habit }
        } else {
            favorites.append(habit)
        }
        favoriteHabits = favorites
    }
}

enum Setting {
    static let favoriteHabits = "favoriteHabits"
}
