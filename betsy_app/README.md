# Betsy - Gentle Activity Tracking for Seniors

A beautiful, senior-friendly Flutter app that helps older adults stay active and connected through gentle motivation, inspirational storytelling, and shame-free activity tracking.

## 🌟 Key Features

### Innovative UI/UX Improvements Beyond the PRD:

1. **Animated Streak Card** - Gentle pulsing animation with gradient colors that create a warm, encouraging feeling
2. **One-Tap Activity Logging** - Large, accessible buttons with haptic feedback for easy interaction
3. **Celebration Animations** - Delightful star and confetti animations that make logging activities feel rewarding
4. **Progressive Onboarding** - Step-by-step introduction with visual progress indicators
5. **High Contrast Design** - Carefully chosen colors with WCAG AA compliance for accessibility
6. **Contextual Greetings** - Time-aware messages that feel personal and caring
7. **Visual Week Summary** - Easy-to-understand dot visualization of weekly activity

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- iOS Simulator or Android Emulator
- Xcode (for iOS development)
- Android Studio (for Android development)

### Installation

1. Clone the repository:
```bash
cd /Users/perryjosey/BetsyClaude/betsy_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📱 App Structure

```
lib/
├── core/
│   ├── theme/          # Design system and theme
│   └── constants/      # Activity types and constants
├── features/
│   ├── home/          # Home screen
│   ├── activities/    # Activity logging
│   ├── stories/       # Daily inspiration stories
│   ├── gamification/  # Streaks and badges
│   └── onboarding/    # First-time user flow
└── widgets/           # Reusable components
```

## 🎨 Design Philosophy

The app is designed with seniors in mind:

- **Large Touch Targets**: Minimum 56px for easy tapping
- **Clear Typography**: 18sp+ body text for readability
- **Gentle Motivation**: No harsh penalties for missed days
- **Warm Colors**: Soft gradients and pastels that feel inviting
- **Simple Navigation**: Single-column layouts with clear hierarchy

## 🔧 Technical Details

- **Framework**: Flutter 3.24+
- **State Management**: Provider/Riverpod (to be implemented)
- **Backend**: Supabase (to be integrated)
- **Analytics**: Firebase Analytics (to be added)

## 📈 Next Steps

1. Integrate Supabase for data persistence
2. Add state management solution
3. Implement family sharing features
4. Add voice input for accessibility
5. Create badge system with more celebrations
6. Build settings and profile screens

## 🤝 Contributing

This app is designed to help seniors stay active and connected. When contributing, please keep accessibility and ease of use as top priorities.
