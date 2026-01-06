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
                TextState("您的角色是")
            } actions: {
                ButtonState(action: .finish) {
                    TextState("確認")
                }
            } message: {
                TextState(roles[index].name)
            }
        }
    }
}

