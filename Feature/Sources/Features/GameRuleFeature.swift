//
//  GameRuleFeature.swift
//  AvalonPackage
//
//  Created by Luan on 11/4/25.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct GameRuleFeature {
    @ObservableState
    public struct State: Equatable {

        public init() {}
    }

    public enum Action: Equatable {}

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce(core)
    }

    public func core(state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}
