//
//  UserDetailView.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    @State private var updateTimer: Timer?
    var viewModel = UserDetailViewModel()

    var body: some View {
        GeometryReader { proxy in
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 20.0) {
                        AsyncImage(url: ImageRequest(imageID: user.id).imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundStyle(Color(.systemGray5))
                        }
                        .frame(maxWidth: 0.3 * proxy.size.width)

                        Text(user.name)
                    }
                    Text(user.bio ?? "")
                }
                .padding(.horizontal)
                .padding(.top, 20)

                List {}
                    .listStyle(.plain)
                    .padding(.top, 20)
            }
        }
        .onAppear {
            updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                Task {
                    await viewModel.update(user: user)
                }
            }
        }
        .onDisappear {
            updateTimer?.invalidate()
            updateTimer = nil
        }
    }
}

#Preview {
    UserDetailView(user: User.sampleUser)
}
