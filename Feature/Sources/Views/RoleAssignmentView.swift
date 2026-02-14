//
//  RoleAssignmentView.swift
//  AvalonPackage
//
//  Created by Luan on 11/2/25.
//

import ComposableArchitecture
import Features
import SwiftUI

@ViewAction(for: RoleAssignmentFeature.self)
public struct RoleAssignmentView: View {

    @Bindable
    public var store: StoreOf<RoleAssignmentFeature>

    public var body: some View {
        List(store.roles.indices, id: \.self) { index in
            Button {
                send(.showRoleTapped(index))
            } label: {
                Text("玩家 \(index + 1)")
            }
        }
        .alert(
            store: store.scope(
                state: \.$confirmationDialog,
                action: \.confirmationDialog
            )
        )
        .alert(store: store.scope(state: \.$roleDialog, action: \.roleDialog))
    }
}

#Preview {
    RoleAssignmentView(
        store: .init(
            initialState: RoleAssignmentFeature.State(roles: [
                .merlin,
                .percival,
                .assassin,
                .morgana,
                .loyalServant,
            ]),
            reducer: {
                RoleAssignmentFeature()
            }
        )
    )
}
