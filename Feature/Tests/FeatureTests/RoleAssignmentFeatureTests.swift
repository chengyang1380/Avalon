//
//  RoleAssignmentFeatureTests.swift
//  AvalonPackage
//
//  Created by Luan on 11/2/25.
//

import ComposableArchitecture
import Features
import Testing

struct RoleAssignmentFeatureTests {
    @Test
    func temp() async throws {
        let store = await TestStore(
            initialState: RoleAssignmentFeature.State()
        ) {
            RoleAssignmentFeature()
        }

        // Add test assertions here

    }
}
