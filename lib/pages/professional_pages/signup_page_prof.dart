import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; 
import '../login_page.dart'; 

class SignupPageProf extends StatefulWidget {
  const SignupPageProf({super.key});

  @override
  State<SignupPageProf> createState() => _SignupPageProfState();
}

class _SignupPageProfState extends State<SignupPageProf> {
  late TapGestureRecognizer _loginTapRecognizer;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _cnpjFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {"#": RegExp(r'\d')});
  final _phoneFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'\d')});
  final _birthDateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()
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
    _nameController.dispose();
    _birthDateController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cnpjController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _defaultRequiredValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return '$fieldName não pode ser vazio.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.40,
            child: Image.asset(
              'lib/assets/img/woman_skincare.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: 48,
            left: 24,
            child: Image.asset('lib/assets/img/logo_camarim.png', width: 100),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.85, 
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      
                      _buildTextFormField(
                        controller: _nameController,
                        label: 'Seu nome completo',
                        validator: (value) => _defaultRequiredValidator(value, 'Nome'),
                      ),

                      _buildTextFormField(
                        controller: _birthDateController,
                        label: 'Data de nascimento (DD/MM/AAAA)',
                        inputFormatters: [_birthDateMask],
                        keyboardType: TextInputType.number, 
                        validator: (value) {
                          final requiredValidation = _defaultRequiredValidator(value, 'Data de Nascimento');
                          if (requiredValidation != null) return requiredValidation;
                          
                          if (_birthDateMask.getUnmaskedText().length != 8) {
                             return 'Data incompleta. Formato DD/MM/AAAA';
                          }
                          return null;
                        },
                      ),

                      _buildTextFormField(
                        controller: _usernameController,
                        label: 'Nome de usuário',
                        validator: (value) => _defaultRequiredValidator(value, 'Nome de Usuário'),
                      ),

                      _buildTextFormField(
                        controller: _emailController,
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final requiredValidation = _defaultRequiredValidator(value, 'E-mail');
                          if (requiredValidation != null) return requiredValidation;

                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!)) {
                            return 'E-mail inválido. Ex: nome@dominio.com';
                          }
                          return null;
                        },
                      ),

                      _buildTextFormField(
                        controller: _phoneController,
                        label: 'Número de telefone',
                        inputFormatters: [_phoneFormatter],
                        keyboardType: TextInputType.phone, 
                        validator: (value) {
                          final requiredValidation = _defaultRequiredValidator(value, 'Telefone');
                          if (requiredValidation != null) return requiredValidation;
                          
                          if (_phoneFormatter.getUnmaskedText().length < 10 || _phoneFormatter.getUnmaskedText().length > 11) {
                            return 'Número incompleto. Ex: (99) 99999-9999';
                          }
                          return null;
                        },
                      ),

                      _buildTextFormField(
                        controller: _cnpjController,
                        label: 'CNPJ',
                        inputFormatters: [_cnpjFormatter],
                        keyboardType: TextInputType.number, 
                        validator: (value) {
                          final requiredValidation = _defaultRequiredValidator(value, 'CNPJ');
                          if (requiredValidation != null) return requiredValidation;
                          
                          if (_cnpjFormatter.getUnmaskedText().length != 14) {
                            return 'CNPJ incompleto';
                          }
                          return null;
                        },
                      ),

                      _buildTextFormField(
                        controller: _passwordController,
                        label: 'Senha',
                        isPassword: true,
                        validator: (value) {
                          final requiredValidation = _defaultRequiredValidator(value, 'Senha');
                          if (requiredValidation != null) return requiredValidation;
                          if (value!.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
                          return null;
                        },
                      ),

                      _buildTextFormField(
                        controller: _confirmPasswordController,
                        label: 'Confirme sua senha',
                        isPassword: true,
                        validator: (value) {
                          final requiredValidation = _defaultRequiredValidator(value, 'Confirmação de Senha');
                          if (requiredValidation != null) return requiredValidation;
                          if (value != _passwordController.text) return 'As senhas não coincidem';
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint('Formulário válido! Iniciando cadastro...');
                              debugPrint('Nome: ${_nameController.text}');
                            } else {
                              debugPrint('Formulário inválido. Corrija os erros.');
                            }
                          },
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
                      _buildSocialButton('Continue com Google', Icons.g_mobiledata),
                      const SizedBox(height: 24), 
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.14,
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
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF737373)),
          floatingLabelStyle: const TextStyle(color: Color(0xFF737373)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off, color: Color(0xFF737373))
              : null,
        ),
        validator: validator, 
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