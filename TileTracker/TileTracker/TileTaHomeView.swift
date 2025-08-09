  import SwiftUI

struct TileTaHomeView: View {
    @ObservedObject var tileTaGameManager: TileTaGameManager
    @State private var tileTaShowInstructions = false
    @State private var tileTaShowFeedback = false
    @State private var tileTaShowRating = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGray6).opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Particle effects
                TileTaParticleView(tileTaIsActive: true)
                    .opacity(0.6)
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Game Title
                        VStack(spacing: 16) {
                            Text("Mahjong")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.blue)
                                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            Text("Tile Tracker")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 15)
                        
                        // Difficulty Selection
                        VStack(spacing: 20) {
                            Text("Choose Difficulty")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.primary)
                            
                            ForEach(TileTaDifficulty.allCases, id: \.self) { difficulty in
                                TileTaDifficultyCard(
                                    tileTaDifficulty: difficulty,
                                    tileTaHighScore: tileTaGameManager.tileTaGetHighScore(for: difficulty),
                                    tileTaAction: {
                                        tileTaStartGame(difficulty: difficulty)
                                    }
                                )
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.bottom, 30)
                        
                        // Action Buttons
                        VStack(spacing: 16) {
                            HStack(spacing: 20) {
                                TileTaCustomButton(
                                    tileTaTitle: "How to Play",
                                    tileTaAction: {
                                        tileTaShowInstructions = true
                                    },
                                    tileTaBackgroundColor: .green,
                                    tileTaIcon: "questionmark.circle.fill"
                                )
                                
                                TileTaCustomButton(
                                    tileTaTitle: "Feedback",
                                    tileTaAction: {
                                        tileTaShowFeedback = true
                                    },
                                    tileTaBackgroundColor: .orange,
                                    tileTaIcon: "envelope.fill"
                                )
                            }
                            
                            TileTaCustomButton(
                                tileTaTitle: "Rate This App",
                                tileTaAction: {
                                    tileTaShowRating = true
                                },
                                tileTaBackgroundColor: .yellow,
                                tileTaTextColor: .black,
                                tileTaIcon: "star.fill"
                            )
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
                .offset(y: 20)
            }
        }
        .overlay(
            // Instructions Dialog
            TileTaCustomDialog(
                tileTaTitle: "How to Play",
                tileTaMessage: tileTaInstructionsText,
                tileTaPrimaryButtonTitle: "Got It!",
                tileTaPrimaryAction: {
                    tileTaShowInstructions = false
                },
                tileTaSecondaryButtonTitle: nil,
                tileTaSecondaryAction: nil,
                tileTaIsVisible: tileTaShowInstructions
            )
        )
        .overlay(
            // Feedback Dialog
            TileTaCustomDialog(
                tileTaTitle: "Send Feedback",
                tileTaMessage: "We'd love to hear from you! Your feedback helps us improve the game.",
                tileTaPrimaryButtonTitle: "Send Email",
                tileTaPrimaryAction: {
                    tileTaOpenFeedbackEmail()
                    tileTaShowFeedback = false
                },
                tileTaSecondaryButtonTitle: "Cancel",
                tileTaSecondaryAction: {
                    tileTaShowFeedback = false
                },
                tileTaIsVisible: tileTaShowFeedback
            )
        )
        .overlay(
            // Rating Dialog
            TileTaCustomDialog(
                tileTaTitle: "Rate Mahjong Memory",
                tileTaMessage: "If you enjoy playing our game, please take a moment to rate it in the App Store!",
                tileTaPrimaryButtonTitle: "Rate Now",
                tileTaPrimaryAction: {
                    tileTaOpenAppStore()
                    tileTaShowRating = false
                },
                tileTaSecondaryButtonTitle: "Maybe Later",
                tileTaSecondaryAction: {
                    tileTaShowRating = false
                },
                tileTaIsVisible: tileTaShowRating
            )
        )
    }
    
    private var tileTaInstructionsText: String {
        """
        🎯 Objective: Remember and find the target tiles!
        
        📋 How to Play:
        • Choose your difficulty level
        • Memorize the target tile shown at the top
        • Remember its positions on the 4x5 grid
        • When time runs out, tiles flip to show their backs
        • Tap the positions where you saw the target tile
        • Find all target tiles to score 10 points and continue!
        
        ⏱️ Difficulty Levels:
        • Easy: 2 tiles, 10 seconds
        • Medium: 4 tiles, 10 seconds  
        • Hard: 7 tiles, 15 seconds
        
        ⚠️ One wrong tap ends the game!
        """
    }
    
    private func tileTaStartGame(difficulty: TileTaDifficulty) {
        tileTaGameManager.tileTaStartNewGame(difficulty: difficulty)
    }
    
    private func tileTaOpenFeedbackEmail() {
        if let url = URL(string: "mailto:feedback@mahjongmemory.com?subject=Mahjong Memory Feedback") {
            UIApplication.shared.open(url)
        }
    }
    
    private func tileTaOpenAppStore() {
        if let url = URL(string: "https://apps.apple.com/app/id123456789") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    TileTaHomeView(tileTaGameManager: TileTaGameManager())
} 
