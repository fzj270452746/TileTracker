# TileTracker - Mahjong Memory Game

A SwiftUI-based iOS memory game featuring traditional Mahjong tiles with multiple difficulty levels.

## Features

### Game Mechanics
- **Memory Challenge**: Remember positions of target tiles on a 4×5 grid
- **Three Difficulty Levels**:
  - **Easy**: 2 target tiles, 10 seconds memory time
  - **Medium**: 4 target tiles, 10 seconds memory time  
  - **Hard**: 7 target tiles, 15 seconds memory time
- **Scoring System**: 10 points per completed round
- **Progressive Difficulty**: Continue playing to build higher scores

### Technical Features
- **iOS 14+ Compatible**: Supports devices running iOS 14 and above
- **Universal Design**: iPhone optimized with iPad compatibility mode
- **Portrait Orientation**: Designed for vertical gameplay
- **High Score Tracking**: Persistent storage of best scores for each difficulty
- **Smooth Animations**: Custom transitions and particle effects
- **Custom UI Components**: Game-themed dialogs and buttons

### Mahjong Theme
- **Authentic Tiles**: Traditional Mahjong tile designs
- **Three Suits**: Circle (筒), Character (万), Bamboo (条)
- **Values 1-9**: Complete range for each suit
- **Custom Assets**: Hand-crafted tile graphics

## Architecture

### Code Structure
All custom classes, methods, and properties use the `TileTa` prefix for namespace organization:

- **TileTaModels.swift**: Core game models and game manager
- **TileTaComponents.swift**: Reusable UI components
- **TileTaGameView.swift**: Main game interface
- **TileTaHomeView.swift**: Menu and difficulty selection
- **TileTaAnimations.swift**: Visual effects and animations

### Key Components
- **TileTaGameManager**: Central game state management
- **TileTaTile**: Individual tile model with position and state
- **TileTaCustomDialog**: Game-themed popup dialogs
- **TileTaTimerView**: Circular countdown timer
- **TileTaParticleView**: Celebration effects

## Requirements

- **iOS**: 14.0+
- **Xcode**: 12.0+
- **Swift**: 5.0+
- **Devices**: iPhone (primary), iPad (compatibility mode)

## Installation

1. Clone the repository
2. Open `TileTracker.xcodeproj` in Xcode
3. Build and run on iOS Simulator or device

## Gameplay

1. **Select Difficulty**: Choose Easy, Medium, or Hard from the home screen
2. **Memorize Phase**: Study the highlighted target tile and remember its positions
3. **Memory Timer**: Watch the countdown - tiles will flip when time expires
4. **Find Targets**: Tap the positions where you remember seeing the target tile
5. **Score Points**: Successfully find all targets to earn 10 points and continue
6. **Game Over**: One wrong tap ends the game

## High Scores

The game automatically tracks and displays your best score for each difficulty level on the home screen. Scores persist between app sessions.

## Design Principles

- **Accessibility**: Clear visual feedback and intuitive interactions
- **Performance**: Optimized for smooth gameplay on all supported devices  
- **Scalability**: Responsive layout adapts to different screen sizes
- **User Experience**: Polished animations and satisfying game feel

---

*Built with SwiftUI for iOS* 