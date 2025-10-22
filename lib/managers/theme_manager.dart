import 'package:flutter/material.dart';

// PADRÃO OBSERVER (Sujeito): Guarda o estado e notifica observadores.
class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Método chamado pelo Gatilho (o botão).
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    
    // 🔥 ESSENCIAL: Notifica todos os widgets (Observadores) que estão escutando.
    notifyListeners(); 
  }
}
