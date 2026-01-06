//
//  RoleShuffler.swift
//  Feature
//
//  Created by Luan on 12/31/25.
//


import Dependencies
import DependenciesMacros
import Models

@DependencyClient
public struct RoleShuffler: Sendable {
    public var shuffle: @Sendable (_ roles: [Role]) -> [Role] = { $0 }
}

extension RoleShuffler: TestDependencyKey {
    public static let testValue = Self()
}

extension DependencyValues {
    public var roleShuffler: RoleShuffler {
        get { self[RoleShuffler.self] }
        set { self[RoleShuffler.self] = newValue }
    }
}
