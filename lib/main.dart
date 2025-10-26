import 'package:flutter/material.dart';

// O nome do pacote CORRETO é 'camarim_backend' (confirmado pelo Flutter)
// O caminho da pasta é: /pages/professional_pages/horarios_profissional.dart
import 'package:camarim_backend/pages/professional_pages/horarios_profissional.dart'; 

void main() {
  runApp(const AgendaApp());
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda do Profissional',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // O widget AgendaProfissionalPage agora está definido após a importação.
      // O 'const' é removido, pois ele é um StatefulWidget.
      home: AgendaProfissionalPage(), 
    );
  }
}