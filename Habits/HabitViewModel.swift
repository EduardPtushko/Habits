//
//  HabitViewModel.swift
//  Habits
//
//  Created by Eduard Ptushko on 29.01.2024.
//

import Foundation

@Observable
final class HabitViewModel {
    var habitsByName: [String: Habit] = [:]
    var itemsBySection: [Section: [Habit]] = [:]
    var sectionIDs: [HabitViewModel.Section] { itemsBySection.keys.sorted() }

    var favoriteHabits: [Habit] {
        Settings.shared.favoriteHabits
    }

    let service: HabitRequest

    init(service: HabitRequest) {
        self.service = service
    }

    func fetchHabits() async {
        do {
            let habits = try await service.send()
            habitsByName = habits
            update()
        } catch {
            print(error.localizedDescription)
        }
    }

    func update() {
        let itemsBySection = habitsByName.values.reduce(into: [Section: [Habit]]()) { partial, habit in
            let item = habit
            let section: Section
            if favoriteHabits.contains(habit) {
                section = .favorites
            } else {
                section = .category(habit.category)
            }
            partial[section, default: []].append(item)
        }
        self.itemsBySection = itemsBySection.mapValues { $0.sorted() }
    }

    enum Section: Hashable, Comparable {
        case favorites
        case category(_ category: Category)

        static func <(lhs: Section, rhs: Section) -> Bool {
            switch (lhs, rhs) {
            case (.category(let left), .category(let right)):
                left.name < right.name
            case (.favorites, _):
                true
            case (_, .favorites):
                false
            }
        }
    }
}
