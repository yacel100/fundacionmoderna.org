import 'package:flutter/material.dart';

class AppTheme {
  // 🎄 PALETA TRADICIONAL NAVIDEÑA (Misión Navidad)
  static const Color rubyRed = Color(0xFFBE123C); // ❤️ Rojo Rubí principal
  static const Color brightRuby = Color(0xFFE11D48); // Rubí vibrante
  static const Color rubyLightBg = Color(0xFFFFF1F2); // Fondo suave para tags rubí

  static const Color pineGreen = Color(0xFF0F5132); // 🌲 Verde Pino elegante
  static const Color emerald = Color(0xFF16A34A); // Esmeralda / éxito
  static const Color greenLightBg = Color(0xFFF0FDF4); // Fondo suave para tags verdes

  static const Color festiveGold = Color(0xFFD97706); // ⭐ Dorado estrella festiva
  static const Color lightGold = Color(0xFFFEF3C7); // Dorado suave para insignias
  static const Color goldAccent = festiveGold;

  static const Color snowWhite = Color(0xFFFFFFFF);
  static const Color softBackground = Color(0xFFF8FAFC); // Fondo limpio y nítido
  static const Color backgroundLight = Color(0xFFF1F5F9);
  static const Color cardBackground = Colors.white;
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color progressBackground = Color(0xFFE2E8F0);

  // Tipografía y jerarquía de textos
  static const Color textHeading = Color(0xFF0F172A); // Títulos oscuros de alto contraste
  static const Color textDark = Color(0xFF0F172A);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textBody = Color(0xFF334155); // Párrafos legibles
  static const Color textMuted = Color(0xFF64748B); // Texto secundario

  // ☕🎪🎁 Los 3 Pilares Navideños Comunitarios
  static const Color chocoColor = Color(0xFF854D0E); // ☕ Chocolate cálido
  static const Color juegosColor = Color(0xFFD97706); // 🎪 Show y juegos (Dorado alegría)
  static const Color juguetesColor = Color(0xFFBE123C); // 🎁 Juguetes (Rojo Rubí)

  // Compatibilidad con referencias de código
  static const Color modernaGreen = pineGreen;
  static const Color modernaGreenDark = Color(0xFF0A3622);
  static const Color modernaTeal = emerald;
  static const Color modernaBg = softBackground;

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Open Sans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: rubyRed,
        primary: rubyRed,
        secondary: pineGreen,
        tertiary: festiveGold,
        surface: Colors.white,
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
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: rubyRed,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: pineGreen,
          side: const BorderSide(color: pineGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: rubyRed, width: 2),
        ),
      ),
    );
  }
}
