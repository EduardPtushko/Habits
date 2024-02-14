//
//  HabitsApp.swift
//  Habits
//
//  Created by Eduard Ptushko on 14.01.2024.
//

import SwiftUI

@main
struct HabitsApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    let temporaryDirectory = NSTemporaryDirectory()
                    let urlCache = URLCache(
                        memoryCapacity: 25000000,
                        diskCapacity: 50000000,
                        diskPath: temporaryDirectory
                    )
                    URLCache.shared = urlCache
                }
        }
    }
}
