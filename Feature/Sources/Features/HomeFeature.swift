//
//  HomeFeature.swift
//  Avalonpublic
//
//  Created by Luan on 10/24/25.
//

import ComposableArchitecture

@Reducer
public struct HomeFeature {
    @ObservableState
    public struct State: Equatable {
        public var gameRounds = [
            GameRound(roundNumber: 0),
            GameRound(roundNumber: 1),
            GameRound(roundNumber: 2),
            GameRound(roundNumber: 3),
            GameRound(roundNumber: 4),
        ]
    }

    public enum Action: BindableAction {
        case winningSidePicked(id: GameRound.ID, side: GameRound.Side?)
        case binding(BindingAction<State>)
    }

    public init() {}

    public struct GameRound: Identifiable, Equatable {
        public var id: Int { roundNumber }
        public var roundNumber: Int
        public var winningSide: Side?

        public enum Side: Equatable, CaseIterable {
            case good
            case evil

            public var title: String {
                switch self {
                case .good:
                    return "好人獲勝"
                case .evil:
                    return "壞人獲勝"
                }
            }
        }
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce(core)
    }

    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .winningSidePicked(let id, let side):
            state.gameRounds[id].winningSide = side
            return .none

        case .binding:
            return .none

        }
    }
}

// step1: 決定人數及角色
// step2: 抽角色
// step3: 選國王 -> 派發任務
// step4: 所有玩家投票該任務是否可以出
// step5: 出任務的玩家決定任務是否成功
// step6: 公布結果
// step7: 判定遊戲是否結束，若沒結束則回到step3
