//
//  AppFeature.swift
//  Feature
//
//  Created by ChengYangChen on 10/19/25.
//

import ComposableArchitecture
import Models

@Reducer
package struct AppFeature {
    @ObservableState
    package struct State: Equatable {
        package init() {}
    }

    package enum Action: Equatable {
    }

    package init() {}

    package var body: some ReducerOf<Self> {
        Reduce(core)
    }

    package func core(state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}
