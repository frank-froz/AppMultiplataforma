import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        title: 'TMDB Movies',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0B0C14),
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF5A4FCF),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF5A4FCF),
            secondary: Color(0xFF00E5FF),
            surface: Color(0xFF1A1B25),
            background: Color(0xFF0B0C14),
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(color: Colors.white70),
            bodyMedium: TextStyle(color: Colors.white60),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF1A1B25),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0B0C14),
            elevation: 0,
            centerTitle: false,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

