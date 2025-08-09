import SwiftUI

// MARK: - Custom Components

struct TileTaCustomButton: View {
    let tileTaTitle: String
    let tileTaAction: () -> Void
    let tileTaBackgroundColor: Color
    let tileTaTextColor: Color
    let tileTaIcon: String?
    
    init(
        tileTaTitle: String,
        tileTaAction: @escaping () -> Void,
        tileTaBackgroundColor: Color = .blue,
        tileTaTextColor: Color = .white,
        tileTaIcon: String? = nil
    ) {
        self.tileTaTitle = tileTaTitle
        self.tileTaAction = tileTaAction
        self.tileTaBackgroundColor = tileTaBackgroundColor
        self.tileTaTextColor = tileTaTextColor
        self.tileTaIcon = tileTaIcon
    }
    
    var body: some View {
        Button(action: tileTaAction) {
            HStack(spacing: 8) {
                if let icon = tileTaIcon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(tileTaTitle)
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(tileTaTextColor)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(tileTaBackgroundColor)
                    .shadow(color: tileTaBackgroundColor.opacity(0.3), radius: 8, x: 0, y: 4)
            )
        }
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 0.1), value: tileTaBackgroundColor)
    }
}

struct TileTaDifficultyCard: View {
    let tileTaDifficulty: TileTaDifficulty
    let tileTaHighScore: Int
    let tileTaAction: () -> Void
    
    var tileTaCardColor: Color {
        switch tileTaDifficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    var body: some View {
        Button(action: tileTaAction) {
            VStack(spacing: 12) {
                HStack {
                    Text(tileTaDifficulty.tileTaDisplayName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: tileTaDifficultyIcon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Target Tiles: \(tileTaDifficulty.tileTaTargetTileCount)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                        Text("Memory Time: \(Int(tileTaDifficulty.tileTaMemoryTime))s")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("High Score")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                        Text("\(tileTaHighScore)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [tileTaCardColor, tileTaCardColor.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: tileTaCardColor.opacity(0.4), radius: 12, x: 0, y: 6)
            )
        }
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 0.1), value: tileTaCardColor)
    }
    
    private var tileTaDifficultyIcon: String {
        switch tileTaDifficulty {
        case .easy: return "leaf.fill"
        case .medium: return "flame.fill"
        case .hard: return "bolt.fill"
        }
    }
}

struct TileTaCustomDialog: View {
    let tileTaTitle: String
    let tileTaMessage: String
    let tileTaPrimaryButtonTitle: String
    let tileTaPrimaryAction: () -> Void
    let tileTaSecondaryButtonTitle: String?
    let tileTaSecondaryAction: (() -> Void)?
    let tileTaIsVisible: Bool
    
    var body: some View {
        if tileTaIsVisible {
            ZStack {
                // Background overlay
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Prevent dismissing by tapping background
                    }
                
                // Dialog content
                VStack(spacing: 20) {
                    // Title
                    Text(tileTaTitle)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    // Message
                    Text(tileTaMessage)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                    
                    // Buttons
                    VStack(spacing: 12) {
                        TileTaCustomButton(
                            tileTaTitle: tileTaPrimaryButtonTitle,
                            tileTaAction: tileTaPrimaryAction,
                            tileTaBackgroundColor: .blue
                        )
                        
                        if let secondaryTitle = tileTaSecondaryButtonTitle,
                           let secondaryAction = tileTaSecondaryAction {
                            TileTaCustomButton(
                                tileTaTitle: secondaryTitle,
                                tileTaAction: secondaryAction,
                                tileTaBackgroundColor: .gray,
                                tileTaTextColor: .white
                            )
                        }
                    }
                }
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                )
                .padding(.horizontal, 40)
                .scaleEffect(tileTaIsVisible ? 1.0 : 0.8)
                .opacity(tileTaIsVisible ? 1.0 : 0.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: tileTaIsVisible)
            }
        }
    }
}

struct TileTaTileView: View {
    let tileTaTile: TileTaTile
    let tileTaOnTap: () -> Void
    @State private var tileTaIsPressed = false
    
    var body: some View {
        Button(action: tileTaOnTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(tileTaBackgroundGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(tileTaBorderColor, lineWidth: tileTaBorderWidth)
                    )
                
                if tileTaTile.tileTaIsRevealed {
                    Image(tileTaTile.tileTaImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(4)
                        .scaleEffect(tileTaIsPressed ? 0.95 : 1.0)
                } else {
                    Image("jiyi-cover")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(4)
                        .scaleEffect(tileTaIsPressed ? 0.95 : 1.0)
                }
            }
        }
        .scaleEffect(tileTaIsPressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: tileTaIsPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            tileTaIsPressed = pressing
        }, perform: {})
    }
    
    private var tileTaBackgroundGradient: LinearGradient {
        if tileTaTile.tileTaIsTarget && tileTaTile.tileTaIsRevealed {
            return LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.green.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else if tileTaTile.tileTaIsSelected && !tileTaTile.tileTaIsTarget {
            return LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.3), Color.red.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    private var tileTaBorderColor: Color {
        if tileTaTile.tileTaIsTarget && tileTaTile.tileTaIsRevealed {
            return .green
        } else if tileTaTile.tileTaIsSelected && !tileTaTile.tileTaIsTarget {
            return .red
        } else {
            return .gray.opacity(0.3)
        }
    }
    
    private var tileTaBorderWidth: CGFloat {
        if (tileTaTile.tileTaIsTarget && tileTaTile.tileTaIsRevealed) || (tileTaTile.tileTaIsSelected && !tileTaTile.tileTaIsTarget) {
            return 3
        } else {
            return 1
        }
    }
}

struct TileTaTimerView: View {
    let tileTaTimeRemaining: Double
    let tileTaTotalTime: Double
    
    var tileTaProgress: Double {
        guard tileTaTotalTime > 0 else { return 0 }
        return tileTaTimeRemaining / tileTaTotalTime
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Memory Time")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 6)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: tileTaProgress)
                    .stroke(
                        tileTaProgress > 0.3 ? Color.blue : Color.red,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.1), value: tileTaProgress)
                
                Text("\(Int(tileTaTimeRemaining.rounded()))")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(tileTaProgress > 0.3 ? .blue : .red)
            }
        }
    }
}

struct TileTaParticleView: View {
    @State private var tileTaParticles: [TileTaParticle] = []
    let tileTaIsActive: Bool
    
    var body: some View {
        ZStack {
            ForEach(tileTaParticles, id: \.tileTaId) { particle in
                Circle()
                    .fill(particle.tileTaColor)
                    .frame(width: particle.tileTaSize, height: particle.tileTaSize)
                    .position(particle.tileTaPosition)
                    .opacity(particle.tileTaOpacity)
                    .scaleEffect(particle.tileTaScale)
            }
        }
        .onAppear {
            if tileTaIsActive {
                tileTaStartParticleAnimation()
            }
        }
        .onChange(of: tileTaIsActive) { isActive in
            if isActive {
                tileTaStartParticleAnimation()
            } else {
                tileTaParticles.removeAll()
            }
        }
    }
    
    private func tileTaStartParticleAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if !tileTaIsActive {
                timer.invalidate()
                return
            }
            
            tileTaAddParticle()
            tileTaUpdateParticles()
        }
    }
    
    private func tileTaAddParticle() {
        let colors: [Color] = [.yellow, .orange, .red, .pink, .purple, .blue, .green]
        let particle = TileTaParticle(
            tileTaId: UUID(),
            tileTaPosition: CGPoint(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
            ),
            tileTaColor: colors.randomElement() ?? .yellow,
            tileTaSize: CGFloat.random(in: 4...12),
            tileTaOpacity: Double.random(in: 0.3...0.8),
            tileTaScale: CGFloat.random(in: 0.5...1.5)
        )
        tileTaParticles.append(particle)
        
        // Remove old particles
        if tileTaParticles.count > 50 {
            tileTaParticles.removeFirst(10)
        }
    }
    
    private func tileTaUpdateParticles() {
        for i in tileTaParticles.indices {
            tileTaParticles[i].tileTaOpacity *= 0.95
            tileTaParticles[i].tileTaScale *= 0.98
            tileTaParticles[i].tileTaPosition.y -= 2
        }
        
        tileTaParticles.removeAll { $0.tileTaOpacity < 0.1 }
    }
}

struct TileTaParticle {
    let tileTaId: UUID
    var tileTaPosition: CGPoint
    let tileTaColor: Color
    let tileTaSize: CGFloat
    var tileTaOpacity: Double
    var tileTaScale: CGFloat
} 


import UIKit

class TileTacFltAnn: UIView {
    
    // 按钮操作闭包
    var tacShushu: (() -> Void)?
    var tacLoWHsjk: (() -> Void)?
    
    // 子按钮
    private var PLUS: UIButton!
    private var REnEW: UIButton?
    private var ReHom: UIButton?
    
    // 按钮状态
    private var isMenuExpanded = false
    private let animationDuration = 0.3
    private let subButtonSize: CGFloat = 50
    private let spacing: CGFloat = 10
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        PLUS = UIButton(type: .system)
        PLUS.tintColor = .systemBlue
        PLUS.backgroundColor = .white
        PLUS.layer.cornerRadius = 25
        PLUS.layer.shadowColor = UIColor.black.cgColor
        PLUS.layer.shadowOffset = CGSize(width: 0, height: 2)
        PLUS.layer.shadowOpacity = 0.3
        PLUS.layer.shadowRadius = 4
        PLUS.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        PLUS.frame = CGRectMake(0, 0, 50, 50)
        addSubview(PLUS)
        
        self.bounds.size = CGSize(width: 50, height: 50)
        
        PLUS.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        PLUS.setImage(UIImage(systemName: "plus.circle.fill"), for: .highlighted)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        PLUS.addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let superview = superview else { return }
        
        if isMenuExpanded {
            inpandChilds()
            isMenuExpanded.toggle()
        }
        
        let translation = gesture.translation(in: superview)
        center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
        gesture.setTranslation(.zero, in: superview)
    }

    @objc private func toggleMenu() {
        if isMenuExpanded {
            inpandChilds()
        } else {
            cfgchild()
            expandChilds()
        }
        isMenuExpanded.toggle()
    }
    
    // 创建子按钮
    private func cfgchild() {
        guard REnEW == nil, ReHom == nil else { return }
        
        // 刷新按钮
        REnEW = createSubButton(
            imageName: "arrow.clockwise.circle.fill",
            color: .systemGreen,
            action: #selector(refreshTapped))
        
        // 首页按钮
        ReHom = createSubButton(
            imageName: "house.circle.fill",
            color: .systemPurple,
            action: #selector(homeTapped))
    }
    
    private func createSubButton(imageName: String, color: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = color
        button.backgroundColor = .white
        button.layer.cornerRadius = subButtonSize/2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.alpha = 0
        button.frame.size = CGSize(width: subButtonSize, height: subButtonSize)
        
        superview?.addSubview(button)
//        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: subButtonSize),
            button.heightAnchor.constraint(equalToConstant: subButtonSize),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        return button
    }
    
    // 显示子按钮
    private func expandChilds() {
        guard let refreshButton = REnEW,
              let homeButton = ReHom,
              let superview = superview else { return }
        
        // 将子按钮移到最前面
        superview.bringSubviewToFront(self)
        
        // 设置初始位置
        refreshButton.center = center
        homeButton.center = center
        
        // 动画显示
        UIView.animate(withDuration: animationDuration) {
            refreshButton.center.y = self.center.y - self.subButtonSize - self.spacing
            homeButton.center.y = refreshButton.center.y - self.subButtonSize - self.spacing
            
            print(refreshButton.center.y, homeButton.center.y)
            
            refreshButton.alpha = 1
            homeButton.alpha = 1
        }
    }
    
    // 隐藏子按钮
    private func inpandChilds() {
        guard let refreshButton = REnEW,
              let homeButton = ReHom else { return }
        
        UIView.animate(withDuration: animationDuration, animations: {
            refreshButton.center = self.center
            homeButton.center = self.center
            
            refreshButton.alpha = 0
            homeButton.alpha = 0
        }) { _ in
            refreshButton.removeFromSuperview()
            homeButton.removeFromSuperview()
            self.REnEW = nil
            self.ReHom = nil
        }
    }
    
    // MARK: - 按钮动作
    @objc private func refreshTapped() {
        inpandChilds()
        isMenuExpanded = false
        tacShushu?()
    }
    
    @objc private func homeTapped() {
        inpandChilds()
        isMenuExpanded = false
        tacLoWHsjk?()
    }
}
