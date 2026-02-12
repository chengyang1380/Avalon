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

extension Role {
    public var name: String {
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
            return "奧伯倫"
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

    public var imageName: String {
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

    public var roleDescription: String {
        switch self {
        case .merlin:
            return "好人：你可以看到所有壞人，除了大魔王 - 莫德雷德，記得要保護自己的身份，別太明顯，否則會被刺客殺掉"
        case .assassin:
            return "壞人：最後壞人要反敗要靠你了，可以選擇刺殺一個好人，刺殺到「梅林」，壞人就獲勝"
        case .percival:
            return "好人：西瓜皮，可以看到真假梅林（梅林 or 莫甘娜），努力領導好人是你的職責"
        case .morgana:
            return "壞人：壞梅林，表面上看起來和梅林一模一樣，讓西瓜皮（派西維爾）搞不清楚誰是真梅林，是你的優勢也是你的弱點"
        case .mordred:
            return "壞人：大魔王，梅林看不到你，利用這點來混淆梅林吧！"
        case .oberon:
            return "壞人：梅林知道你，但所有壞人都不知道你是壞人，你也不知道其他壞人是誰，獨立行動吧！"
        case .minion,
            .minion1,
            .minion2,
            .minion3:
            return "壞人：邪惡僕從，沒有特殊能力，努力與其他壞人狼狽為奸，讓壞人獲勝吧！"
        case .loyalServant,
            .loyalServant1,
            .loyalServant2,
            .loyalServant3:
            return "好人：忠誠僕從，沒有特殊能力，努力配合梅林和派西維爾，讓好人獲勝吧！"
        }
    }
}
