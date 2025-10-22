import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/theme_manager.dart'; // Importa o Sujeito

// Padrão Observer (Gatilho): Widget interativo que DISPARA a mudança de estado.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Observador de Ícone: Lê o estado atual (sem disparar a notificação) para decidir o ícone.
    final isDarkMode = Provider.of<ThemeManager>(context).themeMode == ThemeMode.dark;

    return FloatingActionButton(
      onPressed: () {
        // 🔥 GATILHO: Dispara o método no Sujeito (ThemeManager).
        // listen: false é usado porque este widget SÓ MANDA A AÇÃO, ele não precisa se reconstruir por causa dela.
        Provider.of<ThemeManager>(context, listen: false).toggleTheme();
      },
      child: Icon(
        // Se estiver Dark, mostra o Sol (para ir para Light); se estiver Light, mostra a Lua (para ir para Dark).
        isDarkMode
          ? Icons.wb_sunny
          : Icons.nights_stay,
      ),
    );
  }
}