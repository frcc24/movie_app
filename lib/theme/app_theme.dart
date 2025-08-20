import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
class AppTheme {
  AppTheme._();

  // Cinematic Dark Foundation Color Palette
  static const Color primaryDark =
      Color(0xFF1A1A2E); // Deep cinematic background
  static const Color secondaryDark =
      Color(0xFF16213E); // Subtle card backgrounds
  static const Color accentColor = Color(0xFFE94560); // Vibrant red for actions
  static const Color surfaceDark =
      Color(0xFF0F0F23); // Bottom navigation surfaces
  static const Color contentWhite = Color(0xFFFFFFFF); // Pure white text
  static const Color mutedText = Color(0xFF8892B0); // Secondary text
  static const Color successColor = Color(0xFF64FFDA); // Genre tags
  static const Color warningColor = Color(0xFFFFB74D); // Content ratings
  static const Color borderColor = Color(0xFF2D3748); // Subtle separation
  static const Color overlayColor = Color(0x66000000); // 40% opacity overlay

  // Light theme colors (minimal usage for this entertainment app)
  static const Color primaryLight = Color(0xFFE94560);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF1A1A2E);

  // Shadow and elevation colors
  static const Color shadowDark = Color(0x1A000000);
  static const Color shadowLight = Color(0x0F000000);

  /// Dark theme (primary theme for entertainment app)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: accentColor,
      onPrimary: contentWhite,
      primaryContainer: accentColor.withValues(alpha: 0.2),
      onPrimaryContainer: contentWhite,
      secondary: successColor,
      onSecondary: primaryDark,
      secondaryContainer: successColor.withValues(alpha: 0.2),
      onSecondaryContainer: contentWhite,
      tertiary: warningColor,
      onTertiary: primaryDark,
      tertiaryContainer: warningColor.withValues(alpha: 0.2),
      onTertiaryContainer: contentWhite,
      error: accentColor,
      onError: contentWhite,
      surface: secondaryDark,
      onSurface: contentWhite,
      onSurfaceVariant: mutedText,
      outline: borderColor,
      outlineVariant: borderColor.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: overlayColor,
      inverseSurface: contentWhite,
      onInverseSurface: primaryDark,
      inversePrimary: accentColor,
    ),
    scaffoldBackgroundColor: primaryDark,
    cardColor: secondaryDark,
    dividerColor: borderColor,

    // AppBar theme for cinematic experience
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: contentWhite,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: contentWhite,
      ),
      iconTheme: const IconThemeData(
        color: contentWhite,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: contentWhite,
        size: 24,
      ),
    ),

    // Card theme with subtle elevation
    cardTheme: CardThemeData(
      color: secondaryDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation for content discovery
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: accentColor,
      unselectedItemColor: mutedText,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button for contextual actions
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: contentWhite,
      elevation: 4,
      focusElevation: 6,
      hoverElevation: 6,
      highlightElevation: 8,
    ),

    // Button themes for modern interaction
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: contentWhite,
        backgroundColor: accentColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: accentColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Typography system for entertainment content
    textTheme: _buildDarkTextTheme(),

    // Input decoration for search and filters
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: mutedText,
        fontSize: 14,
      ),
      hintStyle: GoogleFonts.inter(
        color: mutedText.withValues(alpha: 0.7),
        fontSize: 14,
      ),
      prefixIconColor: mutedText,
      suffixIconColor: mutedText,
    ),

    // Interactive elements
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return mutedText;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor.withValues(alpha: 0.3);
        }
        return borderColor;
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(contentWhite),
      side: const BorderSide(color: borderColor, width: 2),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return borderColor;
      }),
    ),

    // Progress indicators for loading states
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentColor,
      linearTrackColor: borderColor,
      circularTrackColor: borderColor,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: accentColor,
      thumbColor: accentColor,
      overlayColor: accentColor.withValues(alpha: 0.2),
      inactiveTrackColor: borderColor,
      valueIndicatorColor: accentColor,
    ),

    // Tab bar for content categories
    tabBarTheme: TabBarThemeData(
      labelColor: accentColor,
      unselectedLabelColor: mutedText,
      indicatorColor: accentColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceDark.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowDark,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      textStyle: GoogleFonts.inter(
        color: contentWhite,
        fontSize: 12,
      ),
    ),

    // Snackbar for feedback
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: contentWhite,
        fontSize: 14,
      ),
      actionTextColor: accentColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6,
    ),

    // Bottom sheet theme for filters
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surfaceDark,
      modalBackgroundColor: surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),

    // Chip theme for genre tags
    chipTheme: ChipThemeData(
      backgroundColor: successColor.withValues(alpha: 0.2),
      labelStyle: GoogleFonts.inter(
        color: successColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      side: const BorderSide(color: Colors.transparent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceDark),
  );

  /// Light theme (minimal implementation for system compatibility)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryLight.withValues(alpha: 0.1),
      onPrimaryContainer: primaryLight,
      secondary: successColor,
      onSecondary: backgroundLight,
      secondaryContainer: successColor.withValues(alpha: 0.1),
      onSecondaryContainer: primaryLight,
      tertiary: warningColor,
      onTertiary: backgroundLight,
      tertiaryContainer: warningColor.withValues(alpha: 0.1),
      onTertiaryContainer: primaryLight,
      error: primaryLight,
      onError: onPrimaryLight,
      surface: surfaceLight,
      onSurface: onBackgroundLight,
      onSurfaceVariant: onBackgroundLight.withValues(alpha: 0.6),
      outline: borderColor,
      outlineVariant: borderColor.withValues(alpha: 0.3),
      shadow: shadowLight,
      scrim: overlayColor,
      inverseSurface: primaryDark,
      onInverseSurface: contentWhite,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundLight,
    textTheme: _buildLightTextTheme(),
  );

  /// Dark text theme with entertainment-focused typography
  static TextTheme _buildDarkTextTheme() {
    return TextTheme(
      // Display styles for hero content
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        color: contentWhite,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: contentWhite,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: contentWhite,
      ),

      // Headline styles for content titles
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: contentWhite,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: contentWhite,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: contentWhite,
      ),

      // Title styles for cards and sections
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: contentWhite,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: contentWhite,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: contentWhite,
        letterSpacing: 0.1,
      ),

      // Body text for descriptions and content
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: contentWhite,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: contentWhite,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: mutedText,
        letterSpacing: 0.4,
      ),

      // Label styles for UI elements
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: contentWhite,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: mutedText,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.jetBrainsMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: mutedText,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Light text theme (minimal implementation)
  static TextTheme _buildLightTextTheme() {
    return TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: onBackgroundLight,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: onBackgroundLight,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onBackgroundLight,
      ),
    );
  }
}
