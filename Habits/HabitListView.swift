//
//  HabitListView.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import SwiftUI

struct HabitListView: View {
    var viewModel = HabitViewModel(service: HabitRequest())
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(viewModel.sectionIDs, id: \.self) { sectionID in
                    Section {
                        ForEach(viewModel.itemsBySection[sectionID] ?? [], id: \.self) { habit in
                            Button {
                                path.append(habit)
                            } label: {
                                Text(habit.name)
                            }
                            .contextMenu {
                                Button {
                                    Settings.shared.toggleFavorites(habit: habit)
                                } label: {
                                    Text(viewModel.favoriteHabits.contains(habit) ? "Unfavorite" : "Favorite")
                                }
                            }
                        }
                    } header: {
                        Group {
                            switch sectionID {
                            case .favorites:
                                Text("Favorites")
                            case .category(let category):
                                HStack {
                                    Text(category.name)

                                    Spacer()
                                }
                            }
                        }
                        .font(.system(size: 17, weight: .bold))
                        .padding(8)
                        .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .background(Color(.systemGray5))
                    }
                }
                .headerProminence(.increased)
            }
            .listStyle(.plain)
            .navigationTitle("Habits")
            .navigationDestination(for: Habit.self) { habit in
                Text(habit.name)
            }
        }
        .task {
            await viewModel.fetchHabits()
        }
    }
}

#Preview {
    HabitListView()
}
