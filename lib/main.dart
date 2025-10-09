import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_page.dart';

void main() {
  runApp(const CamarimDashboardApp());
}

class CamarimDashboardApp extends StatelessWidget {
  const CamarimDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camarim Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF626BBA), // Roxo principal
          secondary: const Color(0xFF4A4B8F), // Roxo para contraste e detalhes
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.copyWith(
            bodyLarge: const TextStyle(color: Color(0xFF4A4B8F)),
            bodyMedium: const TextStyle(color: Color(0xFF626BBA)),
            titleLarge: const TextStyle(
                color: Color(0xFF4A4B8F), fontWeight: FontWeight.bold),
            titleMedium: const TextStyle(
                color: Color(0xFF4A4B8F), fontWeight: FontWeight.w600),
            titleSmall: const TextStyle(color: Color(0xFF626BBA)),
          ),
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}