import SwiftUI

extension View {
    func tileTaBounceEffect() -> some View {
        self.scaleEffect(1.0)
            .animation(.interpolatingSpring(stiffness: 300, damping: 5), value: UUID())
    }
    
    func tileTaShakeEffect(tileTaIsShaking: Bool) -> some View {
        self.offset(x: tileTaIsShaking ? -5 : 0)
            .animation(.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true), value: tileTaIsShaking)
    }
    
    func tileTaGlowEffect(tileTaColor: Color, tileTaRadius: CGFloat = 10) -> some View {
        self.shadow(color: tileTaColor.opacity(0.6), radius: tileTaRadius, x: 0, y: 0)
    }
}

struct TileTaSuccessAnimation: View {
    @State private var tileTaScale: CGFloat = 0.1
    @State private var tileTaOpacity: Double = 0.0
    @State private var tileTaRotation: Double = 0
    let tileTaIsVisible: Bool
    
    var body: some View {
        if tileTaIsVisible {
            ZStack {
                // Success checkmark
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.green)
                    .scaleEffect(tileTaScale)
                    .opacity(tileTaOpacity)
                    .rotationEffect(.degrees(tileTaRotation))
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                            tileTaScale = 1.2
                            tileTaOpacity = 1.0
                            tileTaRotation = 360
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                tileTaScale = 1.0
                            }
                        }
                    }
                
                // Glow effect
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.green.opacity(0.3),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        )
                    )
                    .frame(width: 120, height: 120)
                    .scaleEffect(tileTaScale * 1.5)
                    .opacity(tileTaOpacity * 0.7)
            }
        }
    }
}

struct TileTaErrorAnimation: View {
    @State private var tileTaScale: CGFloat = 0.1
    @State private var tileTaOpacity: Double = 0.0
    @State private var tileTaShake: Bool = false
    let tileTaIsVisible: Bool
    
    var body: some View {
        if tileTaIsVisible {
            ZStack {
                // Error X mark
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.red)
                    .scaleEffect(tileTaScale)
                    .opacity(tileTaOpacity)
                    .tileTaShakeEffect(tileTaIsShaking: tileTaShake)
                    .onAppear {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            tileTaScale = 1.2
                            tileTaOpacity = 1.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            tileTaShake = true
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                tileTaScale = 1.0
                            }
                        }
                    }
                
                // Error glow
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                Color.red.opacity(0.3),
                                Color.clear
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 60
                        )
                    )
                    .frame(width: 120, height: 120)
                    .scaleEffect(tileTaScale * 1.5)
                    .opacity(tileTaOpacity * 0.7)
            }
        }
    }
}

struct TileTaCountdownAnimation: View {
    let tileTaNumber: Int
    @State private var tileTaScale: CGFloat = 0.1
    @State private var tileTaOpacity: Double = 0.0
    
    var body: some View {
        Text("\(tileTaNumber)")
            .font(.system(size: 120, weight: .bold, design: .rounded))
            .foregroundColor(.blue)
            .scaleEffect(tileTaScale)
            .opacity(tileTaOpacity)
            .onAppear {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    tileTaScale = 1.2
                    tileTaOpacity = 1.0
                }
                
                withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
                    tileTaScale = 0.8
                    tileTaOpacity = 0.0
                }
            }
    }
}

struct TileTaFloatingScore: View {
    let tileTaScore: Int
    @State private var tileTaOffset: CGFloat = 0
    @State private var tileTaOpacity: Double = 1.0
    @State private var tileTaScale: CGFloat = 1.0
    
    var body: some View {
        Text("+\(tileTaScore)")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.green)
            .scaleEffect(tileTaScale)
            .opacity(tileTaOpacity)
            .offset(y: tileTaOffset)
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) {
                    tileTaOffset = -100
                    tileTaOpacity = 0.0
                }
                
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    tileTaScale = 1.5
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeOut(duration: 1.3)) {
                        tileTaScale = 1.0
                    }
                }
            }
    }
}

struct TileTaRippleEffect: View {
    @State private var tileTaRipples: [TileTaRipple] = []
    let tileTaIsActive: Bool
    
    var body: some View {
        ZStack {
            ForEach(tileTaRipples, id: \.tileTaId) { ripple in
                Circle()
                    .stroke(ripple.tileTaColor.opacity(ripple.tileTaOpacity), lineWidth: 2)
                    .frame(width: ripple.tileTaSize, height: ripple.tileTaSize)
                    .position(ripple.tileTaPosition)
                    .scaleEffect(ripple.tileTaScale)
            }
        }
        .onTapGesture {
            // iOS 14 compatible tap gesture without location parameter
        }
    }
    
    private func tileTaAddRipple() {
        let ripple = TileTaRipple(
            tileTaId: UUID(),
            tileTaPosition: CGPoint(x: 150, y: 300), // Default center position
            tileTaColor: .blue,
            tileTaSize: 0,
            tileTaOpacity: 1.0,
            tileTaScale: 0.1
        )
        
        tileTaRipples.append(ripple)
        
        withAnimation(.easeOut(duration: 1.0)) {
            if let index = tileTaRipples.firstIndex(where: { $0.tileTaId == ripple.tileTaId }) {
                tileTaRipples[index].tileTaSize = 200
                tileTaRipples[index].tileTaOpacity = 0.0
                tileTaRipples[index].tileTaScale = 2.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            tileTaRipples.removeAll { $0.tileTaId == ripple.tileTaId }
        }
    }
}

struct TileTaRipple {
    let tileTaId: UUID
    var tileTaPosition: CGPoint
    let tileTaColor: Color
    var tileTaSize: CGFloat
    var tileTaOpacity: Double
    var tileTaScale: CGFloat
}

struct TileTaPulseEffect: ViewModifier {
    @State private var tileTaIsPulsing = false
    let tileTaColor: Color
    let tileTaDuration: Double
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(tileTaColor, lineWidth: 2)
                    .scaleEffect(tileTaIsPulsing ? 1.1 : 1.0)
                    .opacity(tileTaIsPulsing ? 0.0 : 1.0)
                    .animation(.easeInOut(duration: tileTaDuration).repeatForever(autoreverses: false), value: tileTaIsPulsing)
            )
            .onAppear {
                tileTaIsPulsing = true
            }
    }
}

extension View {
    func tileTaPulseEffect(tileTaColor: Color = .blue, tileTaDuration: Double = 1.0) -> some View {
        self.modifier(TileTaPulseEffect(tileTaColor: tileTaColor, tileTaDuration: tileTaDuration))
    }
} 
