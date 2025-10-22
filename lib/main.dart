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
          
          // TEMA CLARO (LIGHT) - Baseado no seu código original
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color.fromARGB(255, 92, 98, 158), 
            colorScheme: const ColorScheme.light().copyWith(
              primary: const Color.fromARGB(255, 92, 98, 158), 
              secondary: Colors.amber, 
              error: Colors.red,
            ),
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
          
          // TEMA ESCURO (DARK) - Essencial para o toggle funcionar corretamente
          darkTheme: ThemeData(
             brightness: Brightness.dark,
             primaryColor: const Color.fromARGB(255, 140, 150, 220), 
             colorScheme: const ColorScheme.dark().copyWith(
              primary: const Color.fromARGB(255, 140, 150, 220),
              secondary: Colors.yellow,
              error: Colors.redAccent,
              background: Colors.grey[900],
              surface: Colors.grey[850], // Fundo de Cards/Campos
            ),
             fontFamily: 'Montserrat',
             textTheme: ThemeData.dark().textTheme.copyWith(
              displayLarge: const TextStyle(fontWeight: FontWeight.w700),
              // ... o restante do seu textTheme Dark
            ),
          ),
          
          home: const SplashScreen(),
        );
      },
    );
  }
}