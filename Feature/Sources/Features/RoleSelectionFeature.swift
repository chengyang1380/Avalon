//
//  RoleSelectionFeature.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture
import Models

/*
 5人    3張    2張
 6人    4張    2張
 7人    4張    3張
 8人    5張    3張
 9人    6張    3張
 10人    6張    4張
 */

@Reducer
public struct RoleSelectionFeature {


    private static let defaultRoles: Set<Role> = [
        .merlin,
        .percival,
        .loyalServant,
        .morgana,
        .assassin,
    ]

    @ObservableState
    public struct State: Equatable {
        public var roles: [Role] = Role.allCases
        public var selectedRoles: Set<Role> = RoleSelectionFeature.defaultRoles

        public init() {}
    }

    public enum Action: ViewAction {
        case view(View)

        public enum View {
            case selectRole(Role)
            case startButtonTapped
            case resetButtonTapepd
        }
    }

    @Reducer(state: .equatable)
    public enum Destination {
        
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce(core)
    }

    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .view(.startButtonTapped):
            return .none

        case .view(.selectRole(let role)):
            if state.selectedRoles.contains(role) {
                state.selectedRoles.remove(role)
            } else {
                state.selectedRoles.insert(role)
            }
            return .none

        case .view(.resetButtonTapepd):
            state.selectedRoles = RoleSelectionFeature.defaultRoles
            return .none
        }
    }
}

