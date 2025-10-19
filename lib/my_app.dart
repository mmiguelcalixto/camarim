import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'manager/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          title: 'Observer Pattern Demo',
          themeMode: themeManager.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const HomePage(),
        );
      },
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
      
        Provider.of<ThemeManager>(context, listen: false).toggleTheme();
      },
      child: const Icon(Icons.brightness_6),
    );
  }
}