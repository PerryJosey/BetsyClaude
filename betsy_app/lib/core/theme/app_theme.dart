import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// "Steady Stride" Design System
/// 
/// Aesthetic: Bold, confident, clean
/// Think: A strong handshake, clear morning, purposeful movement
/// 
/// For seniors who want clarity and confidence, not frills.
class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════
  // STEADY STRIDE COLOR PALETTE
  // Bold contrast, confident colors, clean and direct
  // ═══════════════════════════════════════════════════════════════════════
  
  // Primary: Deep Slate - strong, grounded, confident
  static const Color slate = Color(0xFF2D3748);
  static const Color slateLight = Color(0xFF4A5568);
  static const Color slateDark = Color(0xFF1A202C);

  // Vibrant accents: punchy, modern energy (used sparingly)
  static const Color electricCyan = Color(0xFF00D9FF);
  static const Color electricCyanDark = Color(0xFF00A3C4);
  static const Color hotMagenta = Color(0xFFFF2D8D);
  static const Color hotMagentaDark = Color(0xFFCC1C6E);
  
  // Accent: Bold Amber - energetic, warm but strong
  static const Color amber = Color(0xFFED8936);
  static const Color amberLight = Color(0xFFF6AD55);
  static const Color amberDark = Color(0xFFDD6B20);
  
  // Secondary: Strong Teal - fresh, modern
  static const Color teal = Color(0xFF319795);
  static const Color tealLight = Color(0xFF4FD1C5);
  
  // Success: Confident Green
  static const Color success = Color(0xFF38A169);
  static const Color successLight = Color(0xFF68D391);
  
  // Neutrals: Clean, high contrast
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF7FAFC);
  static const Color gray100 = Color(0xFFEDF2F7);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E0);
  static const Color gray500 = Color(0xFF718096);
  static const Color gray700 = Color(0xFF4A5568);
  
  // Text: Maximum readability
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textMuted = Color(0xFF718096);
  
  // Backgrounds
  static const Color backgroundLight = Color(0xFFF7FAFC);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundWarm = Color(0xFFFFFFFF);
  
  // Legacy aliases for compatibility
  static const Color terracotta = amber;
  static const Color terracottaLight = amberLight;
  static const Color terracottaDark = amberDark;
  static const Color sage = teal;
  static const Color sageLight = tealLight;
  static const Color sageMuted = gray100;
  static const Color walnut = slate;
  static const Color walnutLight = slateLight;
  static const Color cream = gray50;
  static const Color linen = gray100;
  static const Color parchment = gray200;
  static const Color celebration = amber;
  static const Color gentle = amberLight;
  static const Color primaryBlue = slate;
  static const Color warmCoral = amber;
  static const Color successGreen = success;
  static const Color lavenderMist = gray100;
  static const Color sunsetOrange = amber;
  static const Color skyBlue = tealLight;
  static const Color peachPuff = amberLight;
  
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: terracotta,
        brightness: Brightness.light,
      ).copyWith(
        primary: terracotta,
        secondary: sage,
        tertiary: celebration,
        surface: cardBackground,
      ),
      
      // ═══════════════════════════════════════════════════════════════════════
      // TYPOGRAPHY: Warm, readable, characterful
      // Display: Playfair Display (serif) - elegant, warm headlines
      // Body: Source Sans 3 - humanist, highly readable
      // ═══════════════════════════════════════════════════════════════════════
      fontFamily: 'SourceSans3',
      textTheme: TextTheme(
        // Headlines: Warm serif feeling (using weight to suggest serif character)
        displayLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.0,
          height: 1.15,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          height: 1.2,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.3,
          height: 1.25,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          height: 1.3,
          color: textPrimary,
        ),
        // Body: Generous size for seniors, warm line height
        bodyLarge: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w400,
          height: 1.65,
          letterSpacing: 0.15,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          height: 1.55,
          letterSpacing: 0.1,
          color: textSecondary,
        ),
        // Labels: Clear, confident
        labelLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
          color: textSecondary,
        ),
      ),
      
      // ═══════════════════════════════════════════════════════════════════════
      // COMPONENTS: Organic, tactile, warm
      // ═══════════════════════════════════════════════════════════════════════
      
      scaffoldBackgroundColor: cream,
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 64),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          elevation: 0,
          backgroundColor: terracotta,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: walnut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      cardTheme: CardThemeData(
        elevation: 0,
        color: cardBackgroundWarm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: parchment, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: cream,
        foregroundColor: textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: linen,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: parchment, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: parchment, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: terracotta, width: 2),
        ),
        labelStyle: TextStyle(fontSize: 16, color: textSecondary),
        hintStyle: TextStyle(fontSize: 16, color: textMuted),
      ),
      
      dividerTheme: DividerThemeData(
        color: parchment,
        thickness: 1,
        space: spacingL,
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════
  // SPACING: Generous, breathable
  // ═══════════════════════════════════════════════════════════════════════
  static const double spacingXS = 4;
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 48;
  static const double spacingHuge = 64;
  
  // ═══════════════════════════════════════════════════════════════════════
  // ANIMATION: Gentle, breathing, not bouncy
  // ═══════════════════════════════════════════════════════════════════════
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationGentle = Duration(milliseconds: 800);
  static const Duration animationCelebration = Duration(milliseconds: 1200);
  static const Duration animationBreathing = Duration(milliseconds: 2500);
  
  // Curves that feel organic, not mechanical
  static const Curve curveGentle = Curves.easeInOutCubic;
  static const Curve curveBreathing = Curves.easeInOut;
  static const Curve curveEnter = Curves.easeOutCubic;
  static const Curve curveExit = Curves.easeInCubic;
  
  // ═══════════════════════════════════════════════════════════════════════
  // DECORATIONS: Tactile, warm
  // ═══════════════════════════════════════════════════════════════════════
  
  /// Soft shadow for cards - warm, not harsh
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: slate.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: slate.withValues(alpha: 0.06),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Warm gradient for featured elements
  static LinearGradient get warmGradient => LinearGradient(
    colors: [terracotta, terracottaLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Vibrant gradient (use for CTAs and key highlights) - cyan to amber
  static LinearGradient get vibrantGradient => const LinearGradient(
    colors: [electricCyan, amber],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Vibrant "dark" gradient for surfaces like StreakCard - slate with cyan edge
  static LinearGradient get vibrantDarkGradient => LinearGradient(
    colors: [slateDark, slate, electricCyanDark.withValues(alpha: 0.85)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 0.7, 1.0],
  );
  
  /// Sage gradient for success/completion
  static LinearGradient get successGradient => LinearGradient(
    colors: [sage, sageLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Paper texture decoration
  static BoxDecoration get paperDecoration => BoxDecoration(
    color: cardBackgroundWarm,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: gray200, width: 1),
    boxShadow: cardShadow,
  );
}
