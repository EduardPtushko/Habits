//
//  UserListView.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import SwiftUI

struct UserListView: View {
    var viewModel = UserViewModel()
    var columns: [GridItem] = [.init(spacing: 20), .init(spacing: 20)]
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { proxy in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.users, id: \.user) { item in
                            Button {
                                path.append(item.user)
                            } label: {
                                Text(item.user.name)
                                    .padding(EdgeInsets(top: 11, leading: 8, bottom: 11, trailing: 8))
                                    .frame(height: (proxy.size.width - 60) / 2)
                                    .frame(maxWidth: .infinity)
                            }
                            .contextMenu {
                                Button {
                                    Settings.shared.toggleFollowed(user: item.user)
                                    viewModel.setUsers()
                                } label: {
                                    Text(item.isFollowed ? "Unfollow" : "Follow")
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
        .task {
            await viewModel.update()
        }
    }
}

#Preview {
    TabView {
        UserListView()
            .tabItem {
                Label("People", systemImage: "person.2.fill")
            }
    }
}
