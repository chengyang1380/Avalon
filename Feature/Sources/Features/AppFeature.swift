//
//  AppFeature.swift
//  Feature
//
//  Created by ChengYangChen on 10/19/25.
//

import ComposableArchitecture
import Models

@Reducer
public struct AppFeature {
    @ObservableState
    public struct State: Equatable {
        public var home = HomeFeature.State()
        public var roleSelection = RoleSelectionFeature.State()

        public init() {}
    }

    public enum Action {
        case home(HomeFeature.Action)
        case roleSelection(RoleSelectionFeature.Action)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Scope(state: \.roleSelection, action: \.roleSelection) {
            RoleSelectionFeature()
        }
        Reduce(core)
    }

    public func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .home:
            return .none
        case .roleSelection:
            return .none
        }
    }
}
