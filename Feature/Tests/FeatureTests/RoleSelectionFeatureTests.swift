import ComposableArchitecture
import Features
import Testing

struct RoleSelectionFeatureTests {

    @Test
    func selectRole() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        await store.send(.view(.selectRole(.merlin))) {
            $0.selectedRoles = [
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }

        await store.send(.view(.selectRole(.merlin))) {
            $0.selectedRoles = [
                .merlin,
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }
    }

    @Test
    func resetButtonTapepd() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        await store.send(.view(.selectRole(.merlin))) {
            $0.selectedRoles = [
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }

        await store.send(.view(.resetButtonTapped)) {
            $0.selectedRoles = [
                .merlin,
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }
    }
}
