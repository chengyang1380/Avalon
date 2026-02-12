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
        public var path = StackState<Path.State>()
    }

    public enum Action: BindableAction, ViewAction {
        case binding(BindingAction<State>)
        case view(View)
        case path(StackAction<Path.State, Path.Action>)

        public enum View {
            case winningSidePicked(id: GameRound.ID, side: GameRound.Side?)
            case voteButtonTapped
        }
    }

    @Reducer(state: .equatable)
    public enum Path {
        case vote(VoteFeature)
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
            .forEach(\.path, action: \.path)
    }

    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .path:
            return .none

        case .view(.winningSidePicked(let id, let side)):
            state.gameRounds[id].winningSide = side
            return .none

        case .binding:
            return .none

        case .view(.voteButtonTapped):
            state.path.append(.vote(VoteFeature.State()))
            return .none
        }
    }
}

extension HomeFeature.GameRound {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.roundNumber == rhs.roundNumber
            && lhs.winningSide == rhs.winningSide
    }
}
