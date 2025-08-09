import SwiftUI

struct TileTaGameView: View {
    @ObservedObject var tileTaGameManager: TileTaGameManager
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGray6).opacity(0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Header with back button and score
                        TileTaGameHeader(tileTaGameManager: tileTaGameManager)
                            .padding(.horizontal, 16)
                        
                        // Target tile display (only during memorizing phase)
                        if tileTaGameManager.tileTaCurrentState == .memorizing,
                           let targetTile = tileTaGameManager.tileTaTargetTile {
                            TileTaTargetDisplay(tileTaTargetTile: targetTile)
                        }
                        
                        // Timer (only during memorizing phase)
                        if tileTaGameManager.tileTaCurrentState == .memorizing {
                            TileTaTimerView(
                                tileTaTimeRemaining: tileTaGameManager.tileTaMemoryTimeRemaining,
                                tileTaTotalTime: tileTaGameManager.tileTaCurrentDifficulty.tileTaMemoryTime
                            )
                        }
                        
                        // Game instructions
                        TileTaGameInstructions(tileTaGameManager: tileTaGameManager)
                            .padding(.horizontal, 16)
                        
                        // Game Grid
                        TileTaGameGrid(tileTaGameManager: tileTaGameManager, tileTaScreenSize: geometry.size)
                            .padding(.top, 10)
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.top, 10)
                }
                
                // Success particle effects
                if tileTaGameManager.tileTaCurrentState == .roundComplete {
                    TileTaParticleView(tileTaIsActive: true)
                        .opacity(0.8)
                }
            }
        }
        .overlay(
            // Game Over Dialog
            TileTaCustomDialog(
                tileTaTitle: "Game Over!",
                tileTaMessage: "Wrong tile selected!\n\nFinal Score: \(tileTaGameManager.tileTaCurrentScore)\nDifficulty: \(tileTaGameManager.tileTaCurrentDifficulty.tileTaDisplayName)",
                tileTaPrimaryButtonTitle: "Play Again",
                tileTaPrimaryAction: {
                    tileTaGameManager.tileTaStartNewGame(difficulty: tileTaGameManager.tileTaCurrentDifficulty)
                },
                tileTaSecondaryButtonTitle: "Main Menu",
                tileTaSecondaryAction: {
                    tileTaGameManager.tileTaResetGame()
                },
                tileTaIsVisible: tileTaGameManager.tileTaShowGameOverDialog
            )
        )
        .overlay(
            // Round Complete Dialog
            TileTaCustomDialog(
                tileTaTitle: "Excellent!",
                tileTaMessage: "All target tiles found!\n\n+\(tileTaGameManager.tileTaCurrentDifficulty.tileTaPointsPerRound) Points\nTotal Score: \(tileTaGameManager.tileTaCurrentScore)",
                tileTaPrimaryButtonTitle: "Next Round",
                tileTaPrimaryAction: {
                    tileTaGameManager.tileTaContinueToNextRound()
                },
                tileTaSecondaryButtonTitle: "Main Menu",
                tileTaSecondaryAction: {
                    tileTaGameManager.tileTaResetGame()
                },
                tileTaIsVisible: tileTaGameManager.tileTaShowRoundCompleteDialog
            )
        )
        .navigationBarHidden(true)
    }
}

struct TileTaGameHeader: View {
    @ObservedObject var tileTaGameManager: TileTaGameManager
    
    var body: some View {
        HStack {
            // Back button
            TileTaCustomButton(
                tileTaTitle: "Back",
                tileTaAction: {
                    tileTaGameManager.tileTaResetGame()
                },
                tileTaBackgroundColor: .gray,
                tileTaIcon: "chevron.left"
            )
            
            Spacer()
            
            // Score and difficulty
            VStack(alignment: .trailing, spacing: 4) {
                Text("Score: \(tileTaGameManager.tileTaCurrentScore)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(tileTaGameManager.tileTaCurrentDifficulty.tileTaDisplayName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct TileTaTargetDisplay: View {
    let tileTaTargetTile: TileTaTile
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Remember This Tile:")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.primary)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.2), .purple.opacity(0.1)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                
                Image(tileTaTargetTile.tileTaImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 65, height: 85)
            }
        }
        .scaleEffect(1.1)
        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: tileTaTargetTile.tileTaImageName)
    }
}

struct TileTaGameInstructions: View {
    @ObservedObject var tileTaGameManager: TileTaGameManager
    
    var body: some View {
        Text(tileTaInstructionText)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
    
    private var tileTaInstructionText: String {
        switch tileTaGameManager.tileTaCurrentState {
        case .memorizing:
            return "Memorize the positions of the target tile shown above!"
        case .playing:
            let remaining = tileTaGameManager.tileTaCurrentDifficulty.tileTaTargetTileCount - tileTaGameManager.tileTaFoundTargets
            return "Find the remaining \(remaining) target tile\(remaining == 1 ? "" : "s")!"
        default:
            return ""
        }
    }
}

struct TileTaGameGrid: View {
    @ObservedObject var tileTaGameManager: TileTaGameManager
    let tileTaScreenSize: CGSize
    
    private var tileTaGridSpacing: CGFloat { 4 }
    private var tileTaGridPadding: CGFloat { 16 }
    
    private var tileTaTileSize: CGSize {
        // 考虑所有padding：内部12px*2 + 外部4px*2 = 32px
        let totalHorizontalPadding: CGFloat = 32
        let availableWidth = tileTaScreenSize.width - totalHorizontalPadding - (tileTaGridSpacing * 4)
        let tileWidth = availableWidth / 5
        
        // 计算可用高度，考虑顶部内容和底部安全区域
        let topContentHeight: CGFloat = 300 // 估计顶部内容高度
        let bottomSafeArea: CGFloat = 100 // 底部安全区域
        let availableHeight = tileTaScreenSize.height - topContentHeight - bottomSafeArea - (tileTaGridSpacing * 3)
        let maxTileHeight = availableHeight / 4
        
        // 使用更合适的宽高比，并确保不超过可用高度
        let idealTileHeight = tileWidth * 1.2 // 稍微调整宽高比
        let tileHeight = min(idealTileHeight, maxTileHeight)
        
        return CGSize(width: tileWidth, height: tileHeight)
    }
    
    var body: some View {
        VStack(spacing: tileTaGridSpacing) {
            ForEach(0..<tileTaGameManager.tileTaGameTiles.count, id: \.self) { row in
                HStack(spacing: tileTaGridSpacing) {
                    ForEach(0..<tileTaGameManager.tileTaGameTiles[row].count, id: \.self) { col in
                        let tile = tileTaGameManager.tileTaGameTiles[row][col]
                        
                        TileTaTileView(
                            tileTaTile: tile,
                            tileTaOnTap: {
                                tileTaGameManager.tileTaSelectTile(at: tile.tileTaPosition)
                            }
                        )
                        .frame(width: tileTaTileSize.width, height: tileTaTileSize.height)
                        .scaleEffect(tile.tileTaIsSelected ? 1.05 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: tile.tileTaIsSelected)
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6).opacity(0.3))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 4)
    }
}

#Preview {
    TileTaGameView(tileTaGameManager: {
        let manager = TileTaGameManager()
        manager.tileTaStartNewGame(difficulty: .medium)
        return manager
    }())
} 