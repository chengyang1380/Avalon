import ComposableArchitecture
@testable import Features
import Testing
import Models

@MainActor
struct AppFeatureTests {
    @Test
    func initialState() async throws {
        let store = TestStore(
            initialState: AppFeature.State()
        ) { AppFeature() }

        // 驗證初始狀態下，各子 Feature 是否正確初始化
        #expect(store.state.home == HomeFeature.State())
        #expect(store.state.roleSelection == RoleSelectionFeature.State())
    }

    @Test
    func homeTabInteraction() async throws {
        let store = TestStore(
            initialState: AppFeature.State()
        ) { AppFeature() }

        // 測試在 App 層級下，Home 標籤的動作是否能正確分發
        await store.send(.home(.view(.winningSidePicked(id: 0, side: .good)))) {
            $0.home.gameRounds[0].winningSide = .good
        }
    }

    @Test
    func roleSelectionTabInteraction() async throws {
        let store = TestStore(
            initialState: AppFeature.State()
        ) { AppFeature() }

        // 測試在 App 層級下，角色選擇標籤的動作是否能正確分發
        await store.send(.roleSelection(.view(.selectRole(.merlin)))) {
            $0.roleSelection.selectedRoles = [
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }
    }
    
    @Test
    func navigationWithinTabs() async throws {
        let store = TestStore(
            initialState: AppFeature.State()
        ) { AppFeature() }

        // 驗證導覽動作（如顯示規則）在 App 整合層級依然運作
        await store.send(.roleSelection(.view(.infoButtonTapped))) {
            $0.roleSelection.destination = .rule(GameRuleFeature.State())
        }
        
        await store.send(.roleSelection(.destination(.dismiss))) {
            $0.roleSelection.destination = nil
        }
    }
}
