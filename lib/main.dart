import 'package:flutter/material.dart';
import 'paginarecuperarsenha.dart';  // importando a nova página

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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const RedefinirSenhaPage(), // chama a tela que está em outro arquivo
    );
  }
}
