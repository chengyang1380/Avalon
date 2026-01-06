//
//  RoleShufflerLive.swift
//  Feature
//
//  Created by ChengYangChen on 12/25/25.
//

import Dependencies
import DependenciesMacros
import DependencyClients

extension RoleShuffler: DependencyKey {
    public static let liveValue = RoleShuffler(
        shuffle: { $0.shuffled() }
    )
}
