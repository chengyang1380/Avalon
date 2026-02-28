import Testing
import Models
import Features
import DependencyClients
import DependencyClientsLive

struct RoleTests {
    @Test
    func roleProperties_notEmpty() async throws {
        // 驗證每個角色都有基本的顯示資訊，且不為空字串
        for role in Role.allCases {
            #expect(!role.name.isEmpty, "Role \(role) should have a name.")
            #expect(!role.imageName.isEmpty, "Role \(role) should have an imageName.")
            #expect(!role.roleDescription.isEmpty, "Role \(role) should have a description.")
        }
    }
    
    @Test
    func roleIdentifiable() async throws {
        // 驗證 id 的唯一性（這對 IdentifiedCollections 非常重要）
        let ids = Role.allCases.map { $0.id }
        #expect(ids.count == Set(ids).count, "All role IDs should be unique.")
    }
}

struct RoleShufflerTests {
    @Test
    func liveShuffler_integrity() async throws {
        let shuffler = RoleShuffler.liveValue
        let roles: [Role] = [.merlin, .percival, .morgana, .assassin, .loyalServant]
        
        let shuffled = shuffler.shuffle(roles)
        
        // 1. 驗證數量不變
        #expect(shuffled.count == roles.count)
        
        // 2. 驗證內容物完全相同（不論順序）
        #expect(Set(shuffled) == Set(roles))
    }
    
    @Test
    func liveShuffler_isRandom() async throws {
        let shuffler = RoleShuffler.liveValue
        let roles: [Role] = Role.allCases
        
        // 執行多次洗牌，確保結果不完全相同（雖然機率極低，但在大樣本下理論上應有變動）
        var results = Set<[Role]>()
        for _ in 0..<10 {
            results.insert(shuffler.shuffle(roles))
        }
        
        // 只要 10 次洗牌中有超過 1 種以上的結果，即視為具備隨機性
        #expect(results.count > 1, "Shuffler should produce different results across multiple calls.")
    }
}
