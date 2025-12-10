//
//  RoleSelectionFeature.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture
import Models

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
        public var path = StackState<Path.State>()

        @Presents public var destination: Destination.State?

        public init() {}
    }

    public enum Action: ViewAction {
        case view(View)
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<Path.State, Path.Action>)

        public enum View {
            case selectRole(Role)
            case startButtonTapped
            case resetButtonTapepd
            case infoButtonTapped
        }
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case rule(GameRuleFeature)
    }

    @Reducer(state: .equatable)
    public enum Path {
        case assignment(RoleAssignmentFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce(core)
            .ifLet(\.$destination, action: \.destination)
            .forEach(\.path, action: \.path)
    }

    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .destination, .path:
            return .none

        case .view(.startButtonTapped):
            let roles = IdentifiedArray(uncheckedUniqueElements: state.roles)
            state.path.append(
                .assignment(RoleAssignmentFeature.State(roles: roles))
            )
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

        case .view(.infoButtonTapped):
            state.destination = .rule(GameRuleFeature.State())
            return .none
        }
    }
}
