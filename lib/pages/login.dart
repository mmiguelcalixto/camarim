import 'package:camarim_backend/services/firestore.service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Login")
          ],
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Senha"
              ),
            ),
          ),
          GestureDetector(
            onTap: () => firestoreService.signIn(_emailController.text, _passwordController.text),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple
              ),
              child: Text(
                "Fazer login", 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}