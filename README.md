# Avalon (阿瓦隆) - iOS Integrated Development Project

[繁體中文版](#繁體中文) | [English Version](#english)

---

<a name="english"></a>
## English Version

Avalon is a modularized iOS helper app built with **The Composable Architecture (TCA)**. It utilizes the latest **Swift 6** features and the **Swift Testing** framework to provide a robust experience for players of the board game Avalon.

### 🚀 Key Features
- **Role Selection**: Flexible selection of game roles (Merlin, Percival, Morgana, Assassin, Oberon, Mordred, and Loyal/Evil Servants).
- **Role Assignment**: Integrated shuffling logic with hidden role reveal and detailed descriptions.
- **Mission Voting**: Intuitive voting system with double-confirmation and result statistics.
- **Game Tracking (Home)**: Track mission outcomes (Good/Evil victory) across five rounds.

### 🛠 Tech Stack & Architecture
- **Language**: Swift 6.2 (iOS 18+ support)
- **Architecture**: [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture)
- **Testing**: [Swift Testing](https://github.com/apple/swift-testing)
- **Dependency Management**: [Swift Dependencies](https://github.com/pointfreeco/swift-dependencies)

#### Modularized Design (`Feature/` Package)
- **Models**: Core game data structures.
- **DependencyClients**: Abstract interfaces (e.g., `RoleShuffler`).
- **DependencyClientsLive**: Real-world implementations (e.g., `Array.shuffled()`).
- **Features**: Reducer logic for each screen.
- **Views**: SwiftUI component implementations.
- **PublicApp**: Root entry point integrating all modules.

### 🧪 Testing
The project maintains high test coverage:
- **Unit Tests**: Verify role data and shuffling randomness.
- **Feature Tests**: Simulate UI interactions (voting, cancellation, state updates).
- **Integration Tests**: Verify cross-tab state synchronization and navigation.

### 📦 Getting Started
1. Open `Avalon.xcodeproj` with Xcode 16+.
2. Resolve dependencies by clicking `Package.swift` in the `Feature` directory.
3. Run **Cmd + U** to execute all tests.

### 👥 Development Methodology
This project is a showcase of **Human-AI Collaboration**. 
- **Human**: Led the overall architectural design, modularization strategy, and implemented over 50% of the core feature logic.
- **AI**: Collaborated on extensive test coverage (Unit/Feature/Integration), refined edge cases, and assisted in technical documentation.

<a name="繁體中文"></a>
## 繁體中文

這是一個基於 **The Composable Architecture (TCA)** 架構開發的《阿瓦隆》(Avalon) 桌遊輔助 App。專案採用高度模組化的 Swift Package 設計，並運用最新的 **Swift 6** 與 **Swift Testing** 框架。

### 🚀 核心功能
- **角色選擇**: 彈性挑選參與角色（梅林、派西維爾、莫甘娜、刺客、奧伯倫、莫德雷德及僕從）。
- **角色分配**: 內建洗牌邏輯，支援角色暗轉並提供詳細身分描述。
- **任務投票**: 直觀的計票系統，包含二次確認機制與結果統計。
- **戰況紀錄**: 紀錄五局任務的勝負，掌握遊戲節奏。

### 🛠 技術棧與架構
- **語言**: Swift 6.2 (支援 iOS 18+)
- **架構**: [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture)
- **測試框架**: [Swift Testing](https://github.com/apple/swift-testing)
- **依賴管理**: [Swift Dependencies](https://github.com/pointfreeco/swift-dependencies)

#### 模組化設計 (`Feature/` 目錄)
- **Models**: 核心遊戲模型定義。
- **DependencyClients**: 定義抽象介面。
- **DependencyClientsLive**: 真實環境下的功能實作。
- **Features**: 包含各個頁面的 Reducer 邏輯。
- **Views**: 基於 SwiftUI 的視圖實作。
- **PublicApp**: 整合各模組的入口層。

### 🧪 測試覆蓋
本專案具備完善的自動化測試：
- **單元測試**: 驗證角色資料結構與洗牌隨機性。
- **功能測試**: 模擬使用者互動流程（如：投票確認、取消對話框）。
- **整合測試**: 驗證跨頁籤的狀態同步與導覽路徑。

### 📦 如何開始
1. 使用 Xcode 16+ 開啟 `Avalon.xcodeproj`。
2. 點擊 `Feature` 目錄下的 `Package.swift` 以解析依賴項。
3. 執行 **Cmd + U** 跑過所有子模組測試。

### 👥 開發模式
本專案為 **「人機協作 (Human-AI Collaboration)」** 的開發成果：
- **開發者 (Human)**: 負責整體的系統架構設計、模組化策略，並完成超過 50% 的核心功能開發。
- **人工智慧 (AI)**: 協助補全深度測試覆蓋（包含單元、功能與整合測試）、處理邊際案例 (Edge Cases) 的邏輯優化及技術文件撰寫。