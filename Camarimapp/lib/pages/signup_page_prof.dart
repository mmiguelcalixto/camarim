import 'package:flutter/material.dart';

class SignupPageProf extends StatefulWidget {
  const SignupPageProf({super.key});

  @override
  State<SignupPageProf> createState() => _SignupPageProfState();
}

class _SignupPageProfState extends State<SignupPageProf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Profissional'),
      ),
      body: const Center(
        child: Text('Página de cadastro do profissional'),
      ),
    );
  }
}
