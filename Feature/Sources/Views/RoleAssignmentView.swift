//
//  RoleAssignmentView.swift
//  AvalonPackage
//
//  Created by Luan on 11/2/25.
//

import ComposableArchitecture
import Features
import SwiftUI

public struct RoleAssignmentView: View {

    public let store: StoreOf<RoleAssignmentFeature>

    public var body: some View {
        List(store.roles) { role in
            Button {
            } label: {
                Text(role.name)
            }
        }
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
