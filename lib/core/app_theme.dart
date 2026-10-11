import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand constants from the "Fuel IQ Dark" design system, for places that
/// need the exact accent colors rather than a semantic theme role.
abstract class AppColors {
  static const neonGreen = Color(0xFF00FD84);
  static const mintGreen = Color(0xFFA5FFB8);
  static const blue = Color(0xFF5A9FFF);
  static const amber = Color(0xFFFFBD58);
  static const amberContainer = Color(0xFFFAAC1A);
  static const red = Color(0xFFFF716C);
  static const redContainer = Color(0xFF9F0519);
}

abstract class AppTheme {
  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.neonGreen,
      onPrimary: Color(0xFF005B2B),
      primaryContainer: AppColors.neonGreen,
      onPrimaryContainer: Color(0xFF005B2B),
      secondary: AppColors.blue,
      onSecondary: Color(0xFF002044),
      secondaryContainer: Color(0xFF005EB4),
      onSecondaryContainer: Color(0xFFF6F7FF),
      tertiary: AppColors.amber,
      onTertiary: Color(0xFF5C3B00),
      tertiaryContainer: AppColors.amberContainer,
      onTertiaryContainer: Color(0xFF4F3300),
      error: AppColors.red,
      onError: Color(0xFF490006),
      errorContainer: AppColors.redContainer,
      onErrorContainer: Color(0xFFFFA8A3),
      surface: Color(0xFF0B0E12),
      onSurface: Color(0xFFF5F6FC),
      onSurfaceVariant: Color(0xFFA9ABB0),
      outline: Color(0xFF73757A),
      outlineVariant: Color(0xFF45484D),
      surfaceContainerLowest: Color(0xFF000000),
      surfaceContainerLow: Color(0xFF101418),
      surfaceContainer: Color(0xFF161A1F),
      surfaceContainerHigh: Color(0xFF1C2025),
      surfaceContainerHighest: Color(0xFF22262C),
      inverseSurface: Color(0xFFF8F9FF),
      onInverseSurface: Color(0xFF52555A),
      inversePrimary: Color(0xFF006E36),
      surfaceTint: AppColors.mintGreen,
      scrim: Colors.black,
      shadow: Colors.black,
    );

    final textTheme = TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(fontSize: 57, fontWeight: FontWeight.w600),
      displayMedium: GoogleFonts.spaceGrotesk(fontSize: 45, fontWeight: FontWeight.w600),
      displaySmall: GoogleFonts.spaceGrotesk(fontSize: 36, fontWeight: FontWeight.w600),
      headlineLarge: GoogleFonts.spaceGrotesk(fontSize: 32, fontWeight: FontWeight.w700),
      headlineMedium: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700),
      headlineSmall: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.inter(fontSize: 16),
      bodyMedium: GoogleFonts.inter(fontSize: 14),
      bodySmall: GoogleFonts.inter(fontSize: 12),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.neonGreen,
          foregroundColor: const Color(0xFF005B2B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue,
          side: const BorderSide(color: AppColors.blue),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? AppColors.neonGreen : colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final active = states.contains(WidgetState.selected);
          return IconThemeData(color: active ? AppColors.neonGreen : colorScheme.onSurfaceVariant);
        }),
      ),
    );
  }
}
