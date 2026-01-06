//
//  HomeView.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture
import Features
import SwiftUI

public struct HomeView: View {
    @Bindable public var store: StoreOf<HomeFeature>

    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            VStack {
                Text("五戰三勝，壞人贏三回合就結束了，好人贏三回合後，還要由刺客刺殺梅林後才知道結果！")
                ForEach(store.gameRounds) { round in
                    WinnerSidePicker(
                        selection: Binding(
                            get: { round.winningSide },
                            set: { store.send(.winningSidePicked(id: round.id, side: $0)) }
                        )
                    )
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        action: {

                        },
                        label: {
                            Text("投票")
                        }
                    )
                }
            }
        }

        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Home")
        .padding()
    }
}

struct WinnerSidePicker: View {
    @Binding var selection: HomeFeature.GameRound.Side?

    var body: some View {
        Picker("選擇勝利方", selection: $selection) {
            Text("無").tag(HomeFeature.GameRound.Side?.none)
            ForEach(HomeFeature.GameRound.Side.allCases, id: \.self) { side in
                Text(side.title).tag(Optional(side))
            }
        }
        .pickerStyle(.segmented)
    }
}
