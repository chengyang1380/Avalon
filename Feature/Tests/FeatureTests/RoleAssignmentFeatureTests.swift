//
//  RoleAssignmentFeatureTests.swift
//  AvalonPackage
//
//  Created by Luan on 11/2/25.
//

import ComposableArchitecture
import Features
import Testing
import Models
import Dependencies
import DependencyClients

struct RoleAssignmentFeatureTests {
    @Test
    func startTapped() async throws {
        let roles: IdentifiedArrayOf<Role> = [
            .merlin,
            .percival,
            .morgana,
            .assassin,
            .loyalServant,
        ]
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State(roles: roles),
            reducer: { RoleAssignmentFeature() },
            withDependencies: {
                $0.roleShuffler = RoleShuffler(shuffle: {
                    $0.reversed()
                })
            }
        )

        await store.send(.view(.startTask)) {
            $0.roles = IdentifiedArrayOf(uniqueElements: roles.reversed())
        }
    }

    @Test
    func showRoleTapped_presentsConfirmationDialog() async throws {
        let roles: IdentifiedArrayOf<Role> = [
            .merlin,
            .percival,
            .morgana,
            .assassin,
            .loyalServant,
        ]
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State(roles: roles),
            reducer: { RoleAssignmentFeature() }
        )

        let tappedIndex = 1 // 玩家2
        await store.send(.view(.showRoleTapped(tappedIndex))) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) {
                    TextState("取消")
                }
                ButtonState(action: .showRoleTapped(tappedIndex)) {
                    TextState("確定")
                }
            } message: {
                TextState("確定您是玩家\(tappedIndex + 1)嗎？")
            }
        }
    }

    @Test
    func confirmationDialog_confirm_showsRoleDialog() async throws {
        let roles: IdentifiedArrayOf<Role> = [
            .merlin,
            .percival,
            .morgana,
            .assassin,
            .loyalServant,
        ]
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State(roles: roles),
            reducer: { RoleAssignmentFeature() }
        )

        let index = 0

        await store.send(.view(.showRoleTapped(index))) {
            $0.confirmationDialog = AlertState {
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
        }

        await store.send(.confirmationDialog(.presented(.showRoleTapped(index)))) {
            $0.confirmationDialog = nil
            $0.roleDialog = AlertState {
                TextState("您的角色是 - \(roles[index].name)")
            } actions: {
                ButtonState(action: .finish) {
                    TextState("確認")
                }
            } message: {
                TextState(roles[index].roleDescription)
            }
        }
    }

    @Test
    func confirmationDialog_dismiss_clearsState() async throws {
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State(roles: [.merlin]),
            reducer: { RoleAssignmentFeature() }
        )

        await store.send(.view(.showRoleTapped(0))) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) {
                    TextState("取消")
                }
                ButtonState(action: .showRoleTapped(0)) {
                    TextState("確定")
                }
            } message: {
                TextState("確定您是玩家1嗎？")
            }
        }

        // 模擬使用者點擊取消或點擊外面關閉對話框
        await store.send(.confirmationDialog(.dismiss)) {
            $0.confirmationDialog = nil
        }
    }

    @Test
    func roleDialog_finish_clearsState() async throws {
        let roles: IdentifiedArrayOf<Role> = [.merlin]
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State(roles: roles),
            reducer: { RoleAssignmentFeature() }
        )

        await store.send(.view(.showRoleTapped(0))) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) {
                    TextState("取消")
                }
                ButtonState(action: .showRoleTapped(0)) {
                    TextState("確定")
                }
            } message: {
                TextState("確定您是玩家1嗎？")
            }
        }

        await store.send(.confirmationDialog(.presented(.showRoleTapped(0)))) {
            $0.confirmationDialog = nil
            $0.roleDialog = AlertState {
                TextState("您的角色是 - 梅林")
            } actions: {
                ButtonState(action: .finish) {
                    TextState("確認")
                }
            } message: {
                TextState(Role.merlin.roleDescription)
            }
        }

        // 模擬點擊「確認」關閉角色對話框
        await store.send(.roleDialog(.presented(.finish))) {
            $0.roleDialog = nil
        }
    }

    @Test
    func sequentialRoleView_worksCorrectly() async throws {
        let roles: IdentifiedArrayOf<Role> = [.merlin, .percival]
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State(roles: roles),
            reducer: { RoleAssignmentFeature() }
        )

        // 第一個玩家查看
        await store.send(.view(.showRoleTapped(0))) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) { TextState("取消") }
                ButtonState(action: .showRoleTapped(0)) { TextState("確定") }
            } message: { TextState("確定您是玩家1嗎？") }
        }
        await store.send(.confirmationDialog(.presented(.showRoleTapped(0)))) {
            $0.confirmationDialog = nil
            $0.roleDialog = .roleDialog(for: roles[0])
        }
        await store.send(.roleDialog(.presented(.finish))) {
            $0.roleDialog = nil
        }

        // 第二個玩家查看
        await store.send(.view(.showRoleTapped(1))) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) { TextState("取消") }
                ButtonState(action: .showRoleTapped(1)) { TextState("確定") }
            } message: { TextState("確定您是玩家2嗎？") }
        }
        await store.send(.confirmationDialog(.presented(.showRoleTapped(1)))) {
            $0.confirmationDialog = nil
            $0.roleDialog = .roleDialog(for: roles[1])
        }
        await store.send(.roleDialog(.presented(.finish))) {
            $0.roleDialog = nil
        }
    }
}

extension AlertState where Action == RoleAssignmentFeature.Action.RoleDialog {
    static func roleDialog(for role: Role) -> Self {
        AlertState {
            TextState("您的角色是 - \(role.name)")
        } actions: {
            ButtonState(action: .finish) {
                TextState("確認")
            }
        } message: {
            TextState(role.roleDescription)
        }
    }
}

