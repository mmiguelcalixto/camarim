import 'package:flutter/material.dart';
import 'menu_page.dart'; // Importa a nossa nova página de menu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MenuPage(), // << Agora a home é a MenuPage
    );
  }
}