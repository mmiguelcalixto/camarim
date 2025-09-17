import 'package:flutter/material.dart';
import 'favoritos_page.dart'; // ou outra página

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camarim',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const FavoritosPage(), // tela inicial
    );
  }
}
