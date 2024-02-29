//
//  HomeView.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var timer: Timer?

    var body: some View {
        Text("Home")
            .task {
                await viewModel.fetch()
            }
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    Task {
                        await viewModel.update()
                    }
                })
            }
            .onDisappear {
                timer = nil
            }
    }
}

#Preview {
    HomeView()
}
