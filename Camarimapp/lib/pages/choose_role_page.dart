import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//import 'signup_page.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  //final _formKey = GlobalKey<FormState>();
  //bool _obscure = true;
  late TapGestureRecognizer _tapGestureRecognizer;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _selectRole(String role) {
    // Aqui você pode tratar a seleção, ex: navegar ou salvar estado
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Selecionou: $role')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset(
              'assets/img/woman_skincare.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0, -0.3),
            ),
          ),
          Positioned(
            top: 48,
            left: 24,
            child: Image.asset('assets/img/logo_camarim.png', width: 100),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            left: 20,
            child: const Text(
              'Cadastrar',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 38,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Caixa branca arredondada na parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Escolha sua função:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRoleCard(
                          label: 'Sou cliente',
                          icon: Icons.person,
                          onTap: () => _selectRole('Cliente'),
                        ),
                        _buildRoleCard(
                          label: 'Sou profissional',
                          icon: Icons.work,
                          onTap: () => _selectRole('Profissional'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: Colors.black87),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
