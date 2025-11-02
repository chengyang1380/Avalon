//
//  HomeView.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture
import SwiftUI
import Features

public struct HomeView: View {
    @Bindable public var store: StoreOf<HomeFeature>

    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }

    public var body: some View {
        Text("Hello, Home!")
    }
}

