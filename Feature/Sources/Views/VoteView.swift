//
//  VoteView.swift
//  Feature
//
//  Created by Luan on 02/12/26.
//

import ComposableArchitecture
import Features
import SwiftUI

@ViewAction(for: VoteFeature.self)
public struct VoteView: View {
    @Bindable public var store: StoreOf<VoteFeature>

    public init(store: StoreOf<VoteFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 40) {
            Text("開始投票")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("目前有 \(store.totalVotes) 位玩家投票")
                .font(.title2)
                .foregroundColor(.gray)

            HStack(spacing: 20) {
                VoteButton(
                    title: "成功",
                    icon: "checkmark.shield.fill",
                    color: .green,
                    action: { send(.successButtonTapped) }
                )

                VoteButton(
                    title: "失敗",
                    icon: "xmark.shield.fill",
                    color: .red,
                    action: { send(.failureButtonTapped) }
                )
            }
            .padding()

            showResultButton
        }
        .alert(
            store: store.scope(
                state: \.$confirmationDialog,
                action: \.confirmationDialog
            )
        )
        .alert(store: store.scope(state: \.$voteResultDialog, action: \.voteResultDialog))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var showResultButton: some View {
        Button("公開結果") {
            send(.showResultButtonTapped)
        }
        .font(.title2)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct VoteButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 80))
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(width: 150, height: 200)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(20)
            .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    VoteView(
        store: .init(
            initialState: VoteFeature.State(),
            reducer: { VoteFeature() }
        )
    )
}
