//
//  VoteFeature.swift
//  Feature
//
//  Created by Luan on 02/12/26.
//

import ComposableArchitecture

@Reducer
public struct VoteFeature {

    @ObservableState
    public struct State: Equatable {
        public var successVotes: Int = 0
        public var failureVotes: Int = 0
        public var totalVotes: Int {
            successVotes + failureVotes
        }

        @Presents
        public var confirmationDialog: AlertState<Action.ConfirmationDialog>?

        @Presents
        public var voteResultDialog: AlertState<Action.VoteResultDialog>?

        public init() {}
    }

    public enum Action: ViewAction {
        case view(View)
        case confirmationDialog(PresentationAction<ConfirmationDialog>)
        case voteResultDialog(PresentationAction<VoteResultDialog>)

        public enum View {
            case successButtonTapped
            case failureButtonTapped
            case showResultButtonTapped
        }

        @CasePathable
        public enum ConfirmationDialog: Equatable {
            case voteSuccessConfirmation
            case voteFailureConfirmation
            case confirmShowResult
            case showResult
        }

        @CasePathable
        public enum VoteResultDialog: Equatable {
            case finish
        }
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .view(.successButtonTapped):
                state.confirmationDialog = makeConfirmationDialog(
                    isSuccess: true
                )
                return .none

            case .view(.failureButtonTapped):
                state.confirmationDialog = makeConfirmationDialog(
                    isSuccess: false
                )
                return .none

            case .view(.showResultButtonTapped):
                state.confirmationDialog = AlertState {
                    TextState("確定顯示任務投票結果？")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("取消")
                    }
                    ButtonState(action: .confirmShowResult) {
                        TextState("確認")
                    }
                }
                return .none

            case .confirmationDialog(.presented(.voteSuccessConfirmation)):
                state.successVotes += 1
                return .none

            case .confirmationDialog(.presented(.voteFailureConfirmation)):
                state.failureVotes += 1
                return .none

            case .confirmationDialog(.presented(.confirmShowResult)):
                state.voteResultDialog = AlertState {
                    TextState("投票結果")
                } actions: {
                    ButtonState(action: .finish) {
                        TextState("確認")
                    }
                } message: { [state] in
                    TextState(
                        "成功票數：\(state.successVotes) \n 失敗票數：\(state.failureVotes)"
                    )
                }
                return .none

            case .confirmationDialog, .voteResultDialog:
                return .none
            }
        }
        .ifLet(\.$confirmationDialog, action: \.confirmationDialog)
        .ifLet(\.$voteResultDialog, action: \.voteResultDialog)
    }
}

extension VoteFeature {
    private func makeConfirmationDialog(isSuccess: Bool) -> AlertState<
        Action.ConfirmationDialog
    > {
        let title = "注意"
        let message = "確定您要投下「任務\(isSuccess ? "成功" : "失敗")」嗎？"
        let action: Action.ConfirmationDialog =
            isSuccess ? .voteSuccessConfirmation : .voteFailureConfirmation
        return AlertState {
            TextState(title)
        } actions: {
            ButtonState(role: .cancel) {
                TextState("取消")
            }
            ButtonState(action: action) {
                TextState("確定")
            }
        } message: {
            TextState(message)
        }
    }
}
