//
//  RoleSelectionView.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture
import Features
import Models
import SwiftUI

@ViewAction(for: RoleSelectionFeature.self)
public struct RoleSelectionView: View {
    @Bindable public var store: StoreOf<RoleSelectionFeature>

    public init(store: StoreOf<RoleSelectionFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            List(store.state.roles) { role in
                Button {
                    send(.selectRole(role))
                } label: {
                    roleRow(for: role)
                }
            }
            .toolbar {
                customToolbar
            }
            .toolbar {
                Button("選角色") {
                    send(.startButtonTapped)
                }
            }
            .navigationTitle("現在總共\(store.state.selectedRoles.count)個人")
            .sheet(
                item: $store.scope(
                    state: \.destination?.rule,
                    action: \.destination.rule
                )
            ) { store in
                NavigationStack {
                    GameRuleView(store: store)
                }
            }
        } destination: { store in
            switch store.state {
            case .assignment:
                if let store = store.scope(
                    state: \.assignment,
                    action: \.assignment
                ) {
                    RoleAssignmentView(store: store)
                }
            }
        }
    }

    private func roleRow(for role: Role) -> some View {
        HStack {
            Image(role.imageName, bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            Text(role.name)
                .font(.headline)
            if store.state.selectedRoles.contains(role) {
                Image(systemName: "checkmark.circle")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
    }

    private var customToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("重置") {
                send(.resetButtonTapepd)
            }
            Button("說明") {
                send(.infoButtonTapped)
            }
        }
    }
}

#Preview {
    RoleSelectionView(
        store: .init(
            initialState: RoleSelectionFeature.State(),
            reducer: { RoleSelectionFeature() }
        )
    )
}
