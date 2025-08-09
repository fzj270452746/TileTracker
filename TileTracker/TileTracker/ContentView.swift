

import SwiftUI

struct ContentView: View {
    @StateObject private var tileTaGameManager = TileTaGameManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                switch tileTaGameManager.tileTaCurrentState {
                case .menu:
                    TileTaHomeView(tileTaGameManager: tileTaGameManager)
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                        
                case .memorizing, .playing, .gameOver, .roundComplete:
                    TileTaGameView(tileTaGameManager: tileTaGameManager)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: tileTaGameManager.tileTaCurrentState)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures consistent behavior on iPad
        .preferredColorScheme(.light) // Force light mode for consistent mahjong theme
        .onAppear {
            tileTaSetupAppearance()
        }
    }
    
    private func tileTaSetupAppearance() {
        // Configure navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    ContentView()
}
