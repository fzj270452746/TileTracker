import SwiftUI
import Foundation

// MARK: - Game Models

enum TileTaSuit: String, CaseIterable {
    case circle = "circle"
    case charac = "charac"
    case bamb = "bamb"
    
    var tileTaDisplayName: String {
        switch self {
        case .circle: return "Circle"
        case .charac: return "Character"
        case .bamb: return "Bamboo"
        }
    }
}

enum TileTaDifficulty: String, CaseIterable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    
    var tileTaDisplayName: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    var tileTaTargetTileCount: Int {
        switch self {
        case .easy: return 2
        case .medium: return 4
        case .hard: return 7
        }
    }
    
    var tileTaMemoryTime: Double {
        switch self {
        case .easy, .medium: return 10.0
        case .hard: return 15.0
        }
    }
    
    var tileTaPointsPerRound: Int {
        return 10
    }
}

enum TileTaGameState {
    case menu
    case memorizing
    case playing
    case gameOver
    case roundComplete
}

struct TileTaTile: Identifiable, Equatable {
    let id = UUID()
    let tileTaSuit: TileTaSuit
    let tileTaValue: Int
    var tileTaIsRevealed: Bool = false
    var tileTaIsTarget: Bool = false
    var tileTaIsSelected: Bool = false
    var tileTaPosition: TileTaGridPosition
    
    var tileTaImageName: String {
        return "jiyi-\(tileTaSuit.rawValue)-\(tileTaValue)"
    }
    
    static func == (lhs: TileTaTile, rhs: TileTaTile) -> Bool {
        return lhs.tileTaSuit == rhs.tileTaSuit && lhs.tileTaValue == rhs.tileTaValue
    }
}

struct TileTaGridPosition: Equatable {
    let tileTaRow: Int
    let tileTaColumn: Int
}

class TileTaGameManager: ObservableObject {
    @Published var tileTaCurrentState: TileTaGameState = .menu
    @Published var tileTaCurrentDifficulty: TileTaDifficulty = .easy
    @Published var tileTaCurrentScore: Int = 0
    @Published var tileTaGameTiles: [[TileTaTile]] = []
    @Published var tileTaTargetTile: TileTaTile?
    @Published var tileTaMemoryTimeRemaining: Double = 0
    @Published var tileTaFoundTargets: Int = 0
    @Published var tileTaShowGameOverDialog: Bool = false
    @Published var tileTaShowRoundCompleteDialog: Bool = false
    
    private let tileTaGridRows = 4
    private let tileTaGridColumns = 5
    private var tileTaTimer: Timer?
    
    // High scores storage
    @Published var tileTaEasyHighScore: Int {
        didSet {
            UserDefaults.standard.set(tileTaEasyHighScore, forKey: "TileTaEasyHighScore")
        }
    }
    
    @Published var tileTaMediumHighScore: Int {
        didSet {
            UserDefaults.standard.set(tileTaMediumHighScore, forKey: "TileTaMediumHighScore")
        }
    }
    
    @Published var tileTaHardHighScore: Int {
        didSet {
            UserDefaults.standard.set(tileTaHardHighScore, forKey: "TileTaHardHighScore")
        }
    }
    
    init() {
        self.tileTaEasyHighScore = UserDefaults.standard.integer(forKey: "TileTaEasyHighScore")
        self.tileTaMediumHighScore = UserDefaults.standard.integer(forKey: "TileTaMediumHighScore")
        self.tileTaHardHighScore = UserDefaults.standard.integer(forKey: "TileTaHardHighScore")
    }
    
    func tileTaStartNewGame(difficulty: TileTaDifficulty) {
        tileTaTimer?.invalidate()
        tileTaCurrentDifficulty = difficulty
        tileTaCurrentScore = 0
        tileTaFoundTargets = 0
        tileTaShowGameOverDialog = false
        tileTaShowRoundCompleteDialog = false
        tileTaStartNewRound()
    }
    
    func tileTaStartNewRound() {
        tileTaCurrentState = .memorizing
        tileTaGenerateGameBoard()
        tileTaMemoryTimeRemaining = tileTaCurrentDifficulty.tileTaMemoryTime
        tileTaStartMemoryTimer()
    }
    
    
    private func tileTaGenerateGameBoard() {
        var newBoard: [[TileTaTile]] = []
        let allSuits = TileTaSuit.allCases
        let targetSuit = allSuits.randomElement()!
        let targetValue = Int.random(in: 1...9)
        
        // Create target tile
        tileTaTargetTile = TileTaTile(
            tileTaSuit: targetSuit,
            tileTaValue: targetValue,
            tileTaPosition: TileTaGridPosition(tileTaRow: 0, tileTaColumn: 0)
        )
        
        // Generate random positions for target tiles
        var targetPositions = Set<String>()
        while targetPositions.count < tileTaCurrentDifficulty.tileTaTargetTileCount {
            let row = Int.random(in: 0..<tileTaGridRows)
            let col = Int.random(in: 0..<tileTaGridColumns)
            targetPositions.insert("\(row)-\(col)")
        }
        
        // Create the game board
        for row in 0..<tileTaGridRows {
            var rowTiles: [TileTaTile] = []
            for col in 0..<tileTaGridColumns {
                let position = TileTaGridPosition(tileTaRow: row, tileTaColumn: col)
                let isTargetPosition = targetPositions.contains("\(row)-\(col)")
                
                if isTargetPosition {
                    let tile = TileTaTile(
                        tileTaSuit: targetSuit,
                        tileTaValue: targetValue,
                        tileTaIsRevealed: true,
                        tileTaIsTarget: true,
                        tileTaPosition: position
                    )
                    rowTiles.append(tile)
                } else {
                    // Generate random tile that's not the target
                    var suit: TileTaSuit
                    var value: Int
                    repeat {
                        suit = allSuits.randomElement()!
                        value = Int.random(in: 1...9)
                    } while suit == targetSuit && value == targetValue
                    
                    let tile = TileTaTile(
                        tileTaSuit: suit,
                        tileTaValue: value,
                        tileTaIsRevealed: true,
                        tileTaPosition: position
                    )
                    rowTiles.append(tile)
                }
            }
            newBoard.append(rowTiles)
        }
        
        tileTaGameTiles = newBoard
    }
    
    private func tileTaStartMemoryTimer() {
        tileTaTimer?.invalidate()
        tileTaTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.tileTaMemoryTimeRemaining > 0 {
                self.tileTaMemoryTimeRemaining -= 0.1
            } else {
                self.tileTaEndMemoryPhase()
            }
        }
    }
    
    private func tileTaEndMemoryPhase() {
        tileTaTimer?.invalidate()
        tileTaCurrentState = .playing
        
        // Hide all tiles
        for row in 0..<tileTaGameTiles.count {
            for col in 0..<tileTaGameTiles[row].count {
                tileTaGameTiles[row][col].tileTaIsRevealed = false
            }
        }
    }
    
    func tileTaSelectTile(at position: TileTaGridPosition) {
        guard tileTaCurrentState == .playing else { return }
        
        let tile = tileTaGameTiles[position.tileTaRow][position.tileTaColumn]
        
        // Reveal the selected tile
        tileTaGameTiles[position.tileTaRow][position.tileTaColumn].tileTaIsRevealed = true
        tileTaGameTiles[position.tileTaRow][position.tileTaColumn].tileTaIsSelected = true
        
        if tile.tileTaIsTarget {
            // Correct selection
            tileTaFoundTargets += 1
            
            if tileTaFoundTargets >= tileTaCurrentDifficulty.tileTaTargetTileCount {
                // Round complete
                tileTaCurrentScore += tileTaCurrentDifficulty.tileTaPointsPerRound
                tileTaUpdateHighScore()
                tileTaCurrentState = .roundComplete
                tileTaShowRoundCompleteDialog = true
            }
        } else {
            // Wrong selection - game over
            tileTaCurrentState = .gameOver
            tileTaShowGameOverDialog = true
        }
    }
    
    private func tileTaUpdateHighScore() {
        switch tileTaCurrentDifficulty {
        case .easy:
            if tileTaCurrentScore > tileTaEasyHighScore {
                tileTaEasyHighScore = tileTaCurrentScore
            }
        case .medium:
            if tileTaCurrentScore > tileTaMediumHighScore {
                tileTaMediumHighScore = tileTaCurrentScore
            }
        case .hard:
            if tileTaCurrentScore > tileTaHardHighScore {
                tileTaHardHighScore = tileTaCurrentScore
            }
        }
    }
    
    func tileTaGetHighScore(for difficulty: TileTaDifficulty) -> Int {
        switch difficulty {
        case .easy: return tileTaEasyHighScore
        case .medium: return tileTaMediumHighScore
        case .hard: return tileTaHardHighScore
        }
    }
    
    func tileTaResetGame() {
        tileTaTimer?.invalidate()
        tileTaCurrentState = .menu
        tileTaCurrentScore = 0
        tileTaFoundTargets = 0
        tileTaGameTiles = []
        tileTaTargetTile = nil
        tileTaShowGameOverDialog = false
        tileTaShowRoundCompleteDialog = false
    }
    
    func tileTaContinueToNextRound() {
        tileTaFoundTargets = 0
        tileTaShowRoundCompleteDialog = false
        tileTaStartNewRound()
    }
} 
