//
//  RoleAssignmentFeature.swift
//  Avalonpublic
//
//  Created by Luan on 11/2/25.
//

import ComposableArchitecture
import Models

@Reducer
public struct RoleAssignmentFeature {
    @ObservableState
    public struct State: Equatable {
        public var roles: IdentifiedArrayOf<Role>

        public init(roles: IdentifiedArrayOf<Role>) {
            self.roles = roles
        }
    }

    public enum Action: Equatable {

    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce(core)
    }

    public func core(state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}
