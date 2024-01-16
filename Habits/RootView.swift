//
//  RootView.swift
//  Habits
//
//  Created by Eduard Ptushko on 14.01.2024.
//

import SwiftUI

struct RootView: View {
    @SceneStorage("selectedTab")
    private var selectedTab = 0

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            HabitListView()
                .tabItem {
                    Label("Habits", systemImage: "star.fill")
                }
                .tag(1)

            UserListView()
                .tabItem {
                    Label("People", systemImage: "person.2.fill")
                }
                .tag(2)

            LogHabitListView()
                .tabItem {
                    Label("Log Habit", systemImage: "checkmark.square.fill")
                }
                .tag(3)
        }
    }
}

#Preview {
    RootView()
}
