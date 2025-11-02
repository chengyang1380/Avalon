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
        Text("")
    }
}

#Preview {
    RoleAssignmentView(
        store: .init(
            initialState: RoleAssignmentFeature.State(),
            reducer: {
                RoleAssignmentFeature()
            }
        )
    )
}
