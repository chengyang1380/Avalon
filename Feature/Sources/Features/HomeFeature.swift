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
        var welcomeMessage: String = "Welcome to the Home Feature!"
    }

    public enum Action {
        case updateWelcomeMessage(String)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce(core)
    }

    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .updateWelcomeMessage(let newMessage):
            state.welcomeMessage = newMessage
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

