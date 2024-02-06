//
//  HabitDetailView.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import SwiftUI

struct HabitDetailView: View {
    let habit: Habit
    var viewModel = HabitDetailViewModel()
    @State private var updateTimer: Timer?

    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(habit.name)
                    .font(.largeTitle)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.9)
                Spacer()
                Text(habit.category.name)
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
            }
            Text(habit.info)
                .font(.headline)
            ScrollView {
                VStack {
                    ForEach(viewModel.userCounts, id: \.user) { item in
                        HStack {
                            Text(item.user.name)
                                .font(.headline)
                            Spacer()
                            Text("\(item.count)")
                                .font(.body)
                        }
                        .frame(height: 44)
                        .padding(.leading, 12)
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .task {
            await viewModel.getHabitStats(habit: habit)
        }
        .onAppear {
            updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                Task {
                    await viewModel.getHabitStats(habit: habit)
                }
            })
        }
        .onDisappear {
            updateTimer?.invalidate()
            updateTimer = nil
        }
    }
}

#Preview {
    HabitDetailView(habit: Habit.sampleHabit)
}
