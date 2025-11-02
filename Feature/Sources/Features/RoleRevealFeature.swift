//
//  RoleRevealFeature.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture

/*
 5人    3張    2張
 6人    4張    2張
 7人    4張    3張
 8人    5張    3張
 9人    6張    3張
 10人    6張    4張
 */

@Reducer
public struct RoleRevealFeature: Reducer {
    public enum Role: String, Identifiable, Equatable, Sendable, CaseIterable {
        public var id: String { rawValue }

        case merlin
        case percival
        case morgana
        case assassin
        case loyalServant
        case loyalServant1
        case loyalServant2
        case loyalServant3
        case oberon
        case minion
        case minion1
        case minion2
        case minion3
        case mordred
    }

    @ObservableState
    public struct State: Equatable {
        public var roles: [Role] = Role.allCases
        public var selectedRoles: Set<Role> = [
            .merlin,
            .percival,
            .loyalServant,
            .morgana,
            .assassin,
        ]

        public init() {}
    }

    public enum Action: ViewAction {
        case view(View)

        public enum View {
            case selectRole(Role)
            case startButtonTapped
        }
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
        }
        return .none
    }
}

extension RoleRevealFeature.Role {
    public var name: String {
        switch self {
        case .merlin:
            return "梅林"
        case .assassin:
            return "刺客"
        case .percival:
            return "派西維爾"
        case .morgana:
            return "莫甘娜"
        case .mordred:
            return "莫德雷德"
        case .oberon:
            return "奧伯龍"
        case .minion,
            .minion1,
            .minion2,
            .minion3:
            return "邪惡僕從"
        case .loyalServant,
            .loyalServant1,
            .loyalServant2,
            .loyalServant3:
            return "忠誠僕從"
        }
    }

    public var imageName: String {
        switch self {
        case .merlin:
            return "merlin"
        case .assassin:
            return "assassin"
        case .percival:
            return "percival"
        case .morgana:
            return "morgana"
        case .mordred:
            return "mordred"
        case .oberon:
            return "oberon"
        case .minion,
            .minion1,
            .minion2,
            .minion3:
            return "minion"
        case .loyalServant,
            .loyalServant1,
            .loyalServant2,
            .loyalServant3:
            return "loyalServant"
        }
    }
}
