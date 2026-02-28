import ComposableArchitecture
import Features
import Testing
import Models

struct RoleSelectionFeatureTests {

    @Test
    func selectRole() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        // 預設有梅林，點擊後應該移除
        await store.send(.view(.selectRole(.merlin))) {
            $0.selectedRoles = [
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }

        // 再次點擊梅林，應該加回來
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
    func resetButtonTapped() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        // 先移除梅林
        await store.send(.view(.selectRole(.merlin))) {
            $0.selectedRoles = [
                .percival,
                .loyalServant,
                .morgana,
                .assassin,
            ]
        }

        // 點擊重置，應該回到預設角色
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

    @Test
    func startButtonTapped_navigatesToAssignment() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        // 使用目前已選角色開始遊戲
        await store.send(.view(.startButtonTapped)) {
            $0.path.append(
                .assignment(RoleAssignmentFeature.State(
                    roles: IdentifiedArray(uncheckedUniqueElements: $0.selectedRoles)
                ))
            )
        }
    }

    @Test
    func infoButtonTapped_presentsRules() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        await store.send(.view(.infoButtonTapped)) {
            $0.destination = .rule(GameRuleFeature.State())
        }
    }

    @Test
    func destination_dismiss_clearsState() async throws {
        let store = await TestStore(
            initialState: RoleSelectionFeature.State()
        ) { RoleSelectionFeature() }

        await store.send(.view(.infoButtonTapped)) {
            $0.destination = .rule(GameRuleFeature.State())
        }

        await store.send(.destination(.dismiss)) {
            $0.destination = nil
        }
    }
}
