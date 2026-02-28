import ComposableArchitecture
import Features
import Testing

struct VoteFeatureTests {
    @Test
    func voteSuccessFlow() async throws {
        let store = await TestStore(
            initialState: VoteFeature.State()
        ) { VoteFeature() }

        // 1. 點擊成功按鈕
        await store.send(.view(.successButtonTapped)) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) { TextState("取消") }
                ButtonState(action: .voteSuccessConfirmation) { TextState("確定") }
            } message: {
                TextState("確定您要投下「任務成功」嗎？")
            }
        }

        // 2. 確認投下成功票
        await store.send(.confirmationDialog(.presented(.voteSuccessConfirmation))) {
            $0.confirmationDialog = nil
            $0.successVotes = 1
        }
    }

    @Test
    func voteFailureFlow() async throws {
        let store = await TestStore(
            initialState: VoteFeature.State()
        ) { VoteFeature() }

        // 1. 點擊失敗按鈕
        await store.send(.view(.failureButtonTapped)) {
            $0.confirmationDialog = AlertState {
                TextState("注意")
            } actions: {
                ButtonState(role: .cancel) { TextState("取消") }
                ButtonState(action: .voteFailureConfirmation) { TextState("確定") }
            } message: {
                TextState("確定您要投下「任務失敗」嗎？")
            }
        }

        // 2. 確認投下失敗票
        await store.send(.confirmationDialog(.presented(.voteFailureConfirmation))) {
            $0.confirmationDialog = nil
            $0.failureVotes = 1
        }
    }

    @Test
    func showResultFlow() async throws {
        var state = VoteFeature.State()
        state.successVotes = 2
        state.failureVotes = 1

        let store = await TestStore(
            initialState: state
        ) { VoteFeature() }

        // 1. 點擊顯示結果按鈕
        await store.send(.view(.showResultButtonTapped)) {
            $0.confirmationDialog = AlertState {
                TextState("確定顯示任務投票結果？")
            } actions: {
                ButtonState(role: .cancel) { TextState("取消") }
                ButtonState(action: .confirmShowResult) { TextState("確認") }
            }
        }

        // 2. 確認顯示結果
        await store.send(.confirmationDialog(.presented(.confirmShowResult))) {
            $0.confirmationDialog = nil
            $0.voteResultDialog = AlertState {
                TextState("投票結果")
            } actions: {
                ButtonState(action: .finish) { TextState("確認") }
            } message: {
                TextState("成功票數：2 \n 失敗票數：1")
            }
        }

        // 3. 點擊確認關閉結果
        await store.send(.voteResultDialog(.presented(.finish))) {
            $0.voteResultDialog = nil
        }
    }
}
