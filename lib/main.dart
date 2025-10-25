import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'managers/theme_manager.dart'; // Importa o Sujeito (ThemeManager)

// Importações de páginas originais (Ajuste estes caminhos se necessário)
import 'package:camarim_backend/pages/professional_pages/prof_horarios_page.dart';
import 'package:camarim_backend/pages/splash_screen.dart'; 

void main() async {
  // Chamadas de inicialização (mantidas comentadas)
  // WidgetsFlutterBinding.ensureInitialized(); 
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(
    // FORNECEDOR (Padrão Observer): Cria e fornece o Sujeito (ThemeManager)
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
    // OBSERVADOR PRINCIPAL: Reage à notificação do ThemeManager para reconstruir o MaterialApp
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        
        return MaterialApp(
          title: 'Camarim',
          debugShowCheckedModeBanner: false,
          
          // 🔥 Observa o estado do ThemeManager para definir o modo do tema (Light/Dark).
          themeMode: themeManager.themeMode, 
          
          // 🌞 TEMA CLARO (LIGHT) - Mantido com o seu esquema de cores
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF5C62A0), 
            scaffoldBackgroundColor: Colors.grey[50],
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5C62A0),
              secondary: Color(0xFFFFC107),
              surface: Color(0xFFF5F5F5),
              error: Colors.redAccent,
            ),
            fontFamily: 'Montserrat', 
            // TextTheme para Light mode (adaptado para o seu original)
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
          
          // 🌙 TEMA ESCURO MODERNO (DARK) - Atualizado com os detalhes do seu outro arquivo
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF8C96DC), // Cor primária mais clara
            scaffoldBackgroundColor: const Color(0xFF1C1C1E), // Fundo principal escuro
            canvasColor: const Color(0xFF2C2C2E), // Cor de canvas/dialogs
            cardColor: const Color(0xFF2E2E30), // Cor de cards e superfícies
            dividerColor: Colors.grey[700],
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8C96DC),
              secondary: Color(0xFFFFD54F), // Amarelo vibrante
              surface: Color(0xFF2E2E30),
              background: Color(0xFF1C1C1E),
              error: Colors.redAccent,
            ),
            fontFamily: 'Montserrat',

            // Garante que o texto seja branco em Dark Mode
            textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ).copyWith(
              // Mantendo suas definições de peso de fonte para consistência
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

            // Tema de AppBar
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1C1C1E),
              foregroundColor: Colors.white,
              elevation: 0,
            ),

            // Tema de Campos de Entrada (TextFields)
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF2E2E30),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(color: Colors.grey[400]),
              labelStyle: TextStyle(color: Colors.grey[300]),
            ),

            // Tema de Botões
            buttonTheme: const ButtonThemeData(
              buttonColor: Color(0xFF8C96DC),
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          
          // Mantendo a página inicial original do segundo arquivo
          home: const SplashScreen(),
        );
      },
    );
  }
}
