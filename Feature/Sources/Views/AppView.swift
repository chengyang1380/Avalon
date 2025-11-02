//
//  AppView.swift
//  Feature
//
//  Created by ChengYangChen on 10/19/25.
//

import ComposableArchitecture
import Features
import SwiftUI

public struct AppView: View {
    var store: StoreOf<AppFeature>

    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    public var body: some View {
        TabView {
            HomeView(store: store.scope(state: \.home, action: \.home))
                .tabItem {
                    Label("首頁", systemImage: "house")
                }
            RoleSelectionView(
                store: store.scope(state: \.roleSelection, action: \.roleSelection)
            )
            .tabItem {
                Label("選擇角色", systemImage: "person.3")
            }

        }
    }
}

#Preview {
    AppView(
        store: .init(
            initialState: AppFeature.State(),
            reducer: { AppFeature() }
        )
    )
}
