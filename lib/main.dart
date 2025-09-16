import 'package:flutter/material.dart';
import 'pagamento_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PagamentoPage(), // << aqui você chama a tela de pagamento
    );
  }
}
