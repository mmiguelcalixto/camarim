import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TapGestureRecognizer _loginTapRecognizer;

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          };
  }

  @override
  void dispose() {
    _loginTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // fundo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height:
                size.height * 0.40, 
            child: Image.asset(
              'assets/img/woman_skincare.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          // logo do camarim
          Positioned(
            top: 48,
            left: 24,
            child: Image.asset('assets/img/logo_camarim.png', width: 100),
          ),

          // titulo CADASTRAR
          Positioned(
            top: 130,
            left: 20,
            child: Text(
              'Cadastrar',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 38,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // tela branca com campos
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.80,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    _buildTextField(label: 'Seu nome completo'),
                    _buildDateField(context),
                    _buildTextField(label: 'Nome de usuário'),
                    _buildTextField(label: 'E-mail'),
                    _buildTextField(label: 'Número de telefone'),
                    _buildTextField(label: 'CPF'),
                    _buildTextField(label: 'Senha', isPassword: true),
                    _buildTextField(
                      label: 'Confirme sua senha',
                      isPassword: true,
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF626BBA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Criar minha conta!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Já tem uma conta? ",
                        style: const TextStyle(color: Color(0xFF737373)),
                        children: [
                          TextSpan(
                            text: "Entrar",
                            recognizer: _loginTapRecognizer,
                            style: const TextStyle(
                              color: Color(0xFF393939),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // divisor
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'ou',
                            style: TextStyle(color: Color(0xFF737373)),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _buildSocialButton('Continue com Apple', Icons.apple),
                    const SizedBox(height: 12),
                    _buildSocialButton('Continue com Facebook', Icons.facebook),
                    const SizedBox(height: 12),
                    _buildSocialButton(
                      'Continue com Google',
                      Icons.g_mobiledata,
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

  Widget _buildTextField({required String label, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF737373)),
          floatingLabelStyle: const TextStyle(color: Color(0xFF737373)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon:
              isPassword
                  ? const Icon(Icons.visibility_off, color: Color(0xFF737373))
                  : null,
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        readOnly: true,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
        },
        decoration: InputDecoration(
          labelText: 'Data de nascimento',
          labelStyle: const TextStyle(color: Color(0xFF737373)),
          floatingLabelStyle: const TextStyle(color: Color(0xFF737373)),
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: Color(0xFF737373),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
