//
//  Role.swift
//  AvalonPackage
//
//  Created by Luan on 11/2/25.
//

public enum Role: String, Identifiable, Equatable, Sendable, CaseIterable {
    public var id: String { rawValue }

    case merlin
    case percival
    case morgana
    case assassin
    case loyalServant
    case loyalServant1
    case loyalServant2
    case loyalServant3
    case oberon
    case minion
    case minion1
    case minion2
    case minion3
    case mordred
}

public extension Role {
     var name: String {
        switch self {
        case .merlin:
            return "梅林"
        case .assassin:
            return "刺客"
        case .percival:
            return "派西維爾"
        case .morgana:
            return "莫甘娜"
        case .mordred:
            return "莫德雷德"
        case .oberon:
            return "奧伯龍"
        case .minion,
            .minion1,
            .minion2,
            .minion3:
            return "邪惡僕從"
        case .loyalServant,
            .loyalServant1,
            .loyalServant2,
            .loyalServant3:
            return "忠誠僕從"
        }
    }

    var imageName: String {
        switch self {
        case .merlin:
            return "merlin"
        case .assassin:
            return "assassin"
        case .percival:
            return "percival"
        case .morgana:
            return "morgana"
        case .mordred:
            return "mordred"
        case .oberon:
            return "oberon"
        case .minion,
            .minion1,
            .minion2,
            .minion3:
            return "minion"
        case .loyalServant,
            .loyalServant1,
            .loyalServant2,
            .loyalServant3:
            return "loyalServant"
        }
    }
}
