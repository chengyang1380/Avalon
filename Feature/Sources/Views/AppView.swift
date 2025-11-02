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
                    Label("Home", systemImage: "house")
                }
            RoleRevealView(
                store: store.scope(state: \.roleReveal, action: \.roleReveal)
            )
            .tabItem {
                Label("Role Reveal", systemImage: "person.3")
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
