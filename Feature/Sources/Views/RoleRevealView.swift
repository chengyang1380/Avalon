//
//  RoleRevealView.swift
//  Avalonpublic
//
//  Created by ChengYangChen on 10/24/25.
//

import ComposableArchitecture
import Features
import SwiftUI

@ViewAction(for: RoleRevealFeature.self)
public struct RoleRevealView: View {
    @Bindable public var store: StoreOf<RoleRevealFeature>

    public init(store: StoreOf<RoleRevealFeature>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            List(store.state.roles) { role in
                Button {
                    send(.selectRole(role))
                } label: {
                    HStack {
                        Image.init(role.imageName, bundle: .module)
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
            }
            .navigationTitle("現在總共\(store.state.selectedRoles.count)個人")
        }
    }
}

#Preview {
    RoleRevealView(
        store: .init(
            initialState: RoleRevealFeature.State(),
            reducer: { RoleRevealFeature() }
        )
    )
}
