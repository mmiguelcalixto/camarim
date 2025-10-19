
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // [NOVO] Adicionado para o Padrão Observer
import 'package:camarim_backend/managers/theme_manager.dart'; 


// Importações originais (ajuste os caminhos se necessário)
import 'package:camarim_backend/pages/professional_pages/prof_horarios_page.dart';
import 'package:camarim_backend/pages/splash_screen.dart';


void main() async {
  
  runApp(
   
    ChangeNotifierProvider(
      create: (context) => ThemeManager(), 
      
      child: const MyApp(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        
        return MaterialApp(
          title: 'Camarim',
          debugShowCheckedModeBanner: false,
          
          themeMode: themeManager.themeMode, // Use o estado atual do Manager
          
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Montserrat',
            textTheme: ThemeData.light().textTheme.copyWith(
              displayLarge: const TextStyle(fontWeight: FontWeight.w700),
              displayMedium: const TextStyle(fontWeight: FontWeight.w700),
              displaySmall: const TextStyle(fontWeight: FontWeight.w700),
              headlineLarge: const TextStyle(fontWeight: FontWeight.w600),
              headlineMedium: const TextStyle(fontWeight: FontWeight.w600),
              headlineSmall: const TextStyle(fontWeight: FontWeight.w600),
              titleLarge: const TextStyle(fontWeight: FontWeight.w600),
              titleMedium: const TextStyle(fontWeight: FontWeight.w600),
              titleSmall: const TextStyle(fontWeight: FontWeight.w600),
              bodyLarge: const TextStyle(fontWeight: FontWeight.w500),
              bodyMedium: const TextStyle(fontWeight: FontWeight.w400),
              bodySmall: const TextStyle(fontWeight: FontWeight.w300),
              labelLarge: const TextStyle(fontWeight: FontWeight.w600),
              labelMedium: const TextStyle(fontWeight: FontWeight.w500),
              labelSmall: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          
          darkTheme: ThemeData(
             brightness: Brightness.dark,
             fontFamily: 'Montserrat',
             
          ),
          
          home: const SplashScreen(),
        );
      },
    );
  }
}