import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scan TextAI',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Color(0xFFba9eff),
          onPrimary: Color(0xFF1a0033),
          primaryContainer: Color(0xFF8455ef),
          onPrimaryContainer: Color(0xFFffd6ff),
          secondary: Color(0xFF699cff),
          onSecondary: Color(0xFF003366),
          secondaryContainer: Color(0xFF4a7bc8),
          onSecondaryContainer: Color(0xFFd6e5ff),
          tertiary: Color(0xFFec4899),
          onTertiary: Color(0xFF4a0033),
          surface: Color(0xFF060e20),
          onSurface: Color(0xFFdee5ff),
          surfaceVariant: Color(0xFF141f38),
          onSurfaceVariant: Color(0xFFa3aac4),
          background: Color(0xFF060e20),
          onBackground: Color(0xFFdee5ff),
          error: Color(0xFFcf6679),
          onError: Color(0xFF140c0d),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFF060e20),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF060e20),
          foregroundColor: Color(0xFFdee5ff),
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFba9eff),
            foregroundColor: const Color(0xFF1a0033),
            elevation: 8,
            shadowColor: const Color(0xFFba9eff).withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF141f38),
          elevation: 12,
          shadowColor: Color(0xFFba9eff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
