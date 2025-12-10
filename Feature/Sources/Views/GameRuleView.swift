//
//  GameRuleView.swift
//  AvalonPackage
//
//  Created by Luan on 11/5/25.
//

import ComposableArchitecture
import Features
import SwiftUI

public struct GameRuleView: View {

    public let store: StoreOf<GameRuleFeature>

    public var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("人數與角色配置"),
                    footer: Text(
                        "好人需包含梅林 + 派西維爾 \n壞人需包含莫甘娜 + 刺客 \n假如有莫德雷德，要加湖中女神機制（建議8人以上再加）"
                    )
                ) {
                    Text("5人：3張好人，2張壞人")
                    Text("6人：4張好人，2張壞人")
                    Text("7人：4張好人，3張壞人")
                    Text("8人：5張好人，3張壞人")
                    Text("9人：6張好人，3張壞人")
                    Text("10人：6張好人，4張壞人")
                }

                Section(
                    header: Text("任務人數配置"),
                    footer: Text("*表示該任務需要兩個失敗票才算任務失敗")
                ) {
                    Text("5人遊戲：\n任務1-5 \n需2-2-3-3-3人")
                    Text("6人遊戲：\n任務1-5 \n需2-3-4-4-4人")
                    Text("7人遊戲：\n任務1-5 \n需2-3-3-4*-4人")
                    Text("8人遊戲：\n任務1-5 \n需3-4-4-5*-5人")
                    Text("9人遊戲：\n任務1-5 \n需3-4-4-5*-5人")
                    Text("10人遊戲：\n任務1-5 \n需3-4-4-5*-5人")
                }

                Section(header: Text("任務一直派不成功")) {
                    Text(
                        "投票決定出任務時，假如反對票比較多或平局，就代表下一家當國王重新投票出任務，但「連續」失敗五次，壞人就直接獲勝，假如有出任務則會 reset 連續失敗次數"
                    )
                }

                Section(header: Text("湖中女神機制")) {
                    Text("大於七人的遊戲才可以使用湖中女神擴充，能力是可以看到其他玩家的陣營")
                    Text("遊戲開始時，將湖中女神指示物(下圖)給領袖右邊的玩家")
                    Text("第2、3、4回合，出完任務後才可以使用湖中女神能力")
                    Text("持有湖中女神指示物的玩家選擇要檢視的對象，但是不可以選擇之前被湖中女神能力看過的玩家")
                    Text("被檢視的玩家將會成為新的湖中女神指示物持有者")
                }

            }
            .listStyle(.insetGrouped)
            .navigationTitle("遊戲規則")
        }
    }
}

#Preview {
    GameRuleView(
        store: .init(
            initialState: GameRuleFeature.State(),
            reducer: {
                GameRuleFeature()
            }
        )
    )
}
