import 'package:flutter/material.dart';

class AppTheme {
  // Colores Oficiales Fundación Moderna (https://fundacionmoderna.org/)
  static const Color modernaGreen = Color(0xFF20BF6B); // #20bf6b insignia
  static const Color modernaGreenDark = Color(0xFF10AC84);
  static const Color modernaGreenLight = Color(0xFFE8F8F0);

  // Acentos temáticos de la Campaña Navideña
  static const Color festivoRuby = Color(0xFFEB4D4B);
  static const Color chocoBrown = Color(0xFF8B4513);
  static const Color alegriaGold = Color(0xFFFFA502);
  static const Color lightGold = Color(0xFFFFF3CD);

  // Compatibilidad semántica con widgets existentes
  static const Color pineGreen = modernaGreen;
  static const Color emerald = modernaGreen;
  static const Color rubyRed = festivoRuby;
  static const Color festiveGold = alegriaGold;
  static const Color textDark = Color(0xFF2D3436);
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textMuted = Color(0xFF747D8C);
  static const Color borderLight = Color(0xFFE4E7EB);
  static const Color softBackground = Color(0xFFF8F9FA);
  static const Color backgroundLight = Color(0xFFF1F2F6);
  static const Color cardBackground = Colors.white;
  static const Color progressBackground = Color(0xFFEDF2F7);

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Open Sans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: modernaGreen,
        primary: modernaGreen,
        secondary: festivoRuby,
        tertiary: alegriaGold,
        surface: softBackground,
      ),
      scaffoldBackgroundColor: softBackground,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 1.5,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: modernaGreen,
          foregroundColor: Colors.white,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: modernaGreen,
          side: const BorderSide(color: modernaGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: modernaGreen, width: 2),
        ),
      ),
    );
  }
}
