import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'login_page.dart';
import '../models/customer.dart';
import '../services/customer.service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TapGestureRecognizer _loginTapRecognizer;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _addressCepController = TextEditingController();
  final _addressStreetController = TextEditingController();
  final _addressNumberController = TextEditingController();
  final _addressNeighborhoodController = TextEditingController();
  final _addressCityController = TextEditingController();
  final _addressStateController = TextEditingController();

  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final _phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');
  final _birthDateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'\d')},
  );

  final CustomerService _customerService = CustomerService();
  bool _isLoading = false;

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
    _nameController.dispose();
    _birthDateController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressCepController.dispose();
    _addressStreetController.dispose();
    _addressNumberController.dispose();
    _addressNeighborhoodController.dispose();
    _addressCityController.dispose();
    _addressStateController.dispose();
    super.dispose();
  }

  void _registerCustomer() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final dateParts = _birthDateController.text.split('/');
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final birthDate = DateTime.utc(year, month, day);

      final newCustomer = Customer(
        fullName: _nameController.text,
        birthDate: birthDate,
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneFormatter.getUnmaskedText(),
        password: _passwordController.text,

        addressStreet: _addressStreetController.text,
        addressNumber: _addressNumberController.text,
        addressNeighborhood: _addressNeighborhoodController.text,
        addressCity: _addressCityController.text,
        addressState: _addressStateController.text,
        addressCep: _addressCepController.text.replaceAll(
          RegExp(r'[^0-9]'),
          '',
        ),
      );

      final bool success = await _customerService.registerCustomer(newCustomer);

      setState(() => _isLoading = false);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conta criada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao criar conta. Verifique os dados.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
              height: size.height * 0.80,
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
                      ),
                      _buildTextFormField(
                        controller: _birthDateController,
                        label: 'Data de nascimento',
                        inputFormatters: [_birthDateMask],
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha este campo';
                          }
                          if (value.length != 10) return 'Formato DD/MM/AAAA';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _usernameController,
                        label: 'Nome de usuário',
                      ),
                      _buildTextFormField(
                        controller: _emailController,
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha este campo';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'E-mail inválido';
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
                          if (value == null || value.isEmpty) {
                            return 'Preencha este campo';
                          }
                          if (value.length < 14) return 'Telefone incompleto';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _cpfController,
                        label: 'CPF',
                        inputFormatters: [_cpfFormatter],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha este campo';
                          }
                          if (value.length != 14) return 'CPF incompleto';
                          return null;
                        },
                      ),

                      _buildTextFormField(
                        controller: _addressCepController,
                        label: 'CEP',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          MaskTextInputFormatter(mask: '#####-###'),
                        ],
                      ),
                      _buildTextFormField(
                        controller: _addressStreetController,
                        label: 'Rua / Logradouro',
                      ),
                      _buildTextFormField(
                        controller: _addressNumberController,
                        label: 'Número',
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextFormField(
                        controller: _addressNeighborhoodController,
                        label: 'Bairro',
                      ),
                      _buildTextFormField(
                        controller: _addressCityController,
                        label: 'Cidade',
                      ),
                      _buildTextFormField(
                        controller: _addressStateController,
                        label: 'Estado (UF)',
                      ),

                      _buildTextFormField(
                        controller: _passwordController,
                        label: 'Senha',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha este campo';
                          }
                          if (value.length < 6) return 'Mínimo de 6 caracteres';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _confirmPasswordController,
                        label: 'Confirme sua senha',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha este campo';
                          }
                          if (value != _passwordController.text) {
                            return 'As senhas não coincidem';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child:
                            _isLoading
                                ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF626BBA),
                                  ),
                                )
                                : ElevatedButton(
                                  onPressed: _registerCustomer,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF626BBA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Criar minha conta!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
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
                      _buildSocialButton(
                        'Continue com Facebook',
                        Icons.facebook,
                      ),
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
    String? Function(String?)? validator,
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
          suffixIcon:
              isPassword
                  ? const Icon(Icons.visibility_off, color: Color(0xFF737373))
                  : null,
        ),
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) return 'Preencha este campo';
              return null;
            },
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
