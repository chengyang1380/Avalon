//
//  RoleAssignmentFeature.swift
//  Avalonpublic
//
//  Created by Luan on 11/2/25.
//

import ComposableArchitecture
import DependencyClients
import Models

@Reducer
public struct RoleAssignmentFeature {

    @ObservableState
    public struct State: Equatable {
        public var roles: IdentifiedArrayOf<Role>

        @Presents
        public var confirmationDialog: AlertState<Action.ConfirmationDialog>?

        @Presents
        public var roleDialog: AlertState<Action.RoleDialog>?

        public init(roles: IdentifiedArrayOf<Role>) {
            self.roles = roles
        }
    }

    public enum Action: ViewAction {
        case view(View)
        case confirmationDialog(PresentationAction<ConfirmationDialog>)
        case roleDialog(PresentationAction<RoleDialog>)

        public enum View {
            case startTask
            case showRoleTapped(Int)
        }

        @CasePathable
        public enum ConfirmationDialog: Equatable {
            case showRoleTapped(Int)
        }

        @CasePathable
        public enum RoleDialog: Equatable {
            case finish
        }
    }

    @Dependency(\.roleShuffler) var roleShuffler

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce(core)
            .ifLet(\.$confirmationDialog, action: \.confirmationDialog)
            .ifLet(\.$roleDialog, action: \.roleDialog)
    }

    public func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .view(.startTask):
            let shuffled = roleShuffler.shuffle(roles: state.roles.elements)
            state.roles = IdentifiedArrayOf(uniqueElements: shuffled)
            return .none

        case .view(.showRoleTapped(let index)):
            state.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) {
                    TextState("取消")
                }
                ButtonState(action: .showRoleTapped(index)) {
                    TextState("確定")
                }
            } message: {
                TextState("確定您是玩家\(index + 1)嗎？")
            }
            return .none

        case .confirmationDialog(.presented(.showRoleTapped(let index))):
            let role = state.roles[index]
            state.roleDialog = AlertState {
                TextState("您的角色是 - \(role.name)")
            } actions: {
                ButtonState(action: .finish) {
                    TextState("確認")
                }
            } message: {
                TextState(role.roleDescription)
            }
            return .none

        case .confirmationDialog,
            .roleDialog:
            return .none

        }
    }
}

