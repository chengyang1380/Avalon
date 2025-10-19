//
//  AppView.swift
//  Feature
//
//  Created by ChengYangChen on 10/19/25.
//

import ComposableArchitecture
import Features
import SwiftUI

package struct AppView: View {
    let store: StoreOf<AppFeature>

    package init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    package var body: some View {
        Text("Hello, Avalon!")
    }
}

#Preview {
    AppView(store: .init(
        initialState: AppFeature.State(),
        reducer: { AppFeature() }
    ))
}
