import ComposableArchitecture
import Features
import Testing
import Models

struct HomeFeatureTests {
    @Test
    func winningSidePicked_updatesState() async throws {
        let store = await TestStore(
            initialState: HomeFeature.State()
        ) { HomeFeature() }

        // 第 1 局挑選「好人獲勝」
        await store.send(.view(.winningSidePicked(id: 0, side: .good))) {
            $0.gameRounds[0].winningSide = .good
        }

        // 第 3 局挑選「壞人獲勝」
        await store.send(.view(.winningSidePicked(id: 2, side: .evil))) {
            $0.gameRounds[2].winningSide = .evil
        }

        // 清除第 1 局的獲勝方
        await store.send(.view(.winningSidePicked(id: 0, side: nil))) {
            $0.gameRounds[0].winningSide = nil
        }
    }

    @Test
    func voteButtonTapped_navigatesToVote() async throws {
        let store = await TestStore(
            initialState: HomeFeature.State()
        ) { HomeFeature() }

        await store.send(.view(.voteButtonTapped)) {
            $0.path.append(.vote(VoteFeature.State()))
        }
    }
}
