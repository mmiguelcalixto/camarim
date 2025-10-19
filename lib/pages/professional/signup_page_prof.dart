import 'dart:convert';
import 'dart:io';

import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/pages/professional/page_perfil.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../customer/login_page.dart';
import 'package:image_picker/image_picker.dart';

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
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _documentController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressStreetController = TextEditingController();
  final _addressNumberController = TextEditingController();
  final _addressNeighborhoodController = TextEditingController();
  final _addressCityController = TextEditingController();
  final _addressStateController = TextEditingController();
  final _addressCepController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // final _cnpjFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##');
  final _phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');
  final _birthDateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'\d')},
  );

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final professionalService = ProfessionalService();
  bool _imageError = false;


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
    _emailController.dispose();
    _phoneController.dispose();
    _documentController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _createProfessional() async {
    if (_selectedImage == null) {
      setState(() {
        _imageError = true;
      });
      Fluttertoast.showToast(
        msg: 'Por favor, selecione uma foto de perfil',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    if (_imageError) {
      setState(() {
        _imageError = false;
      });
    }

    final data = Professional(
      name: _nameController.text, 
      document: _documentController.text, 
      email: _emailController.text, 
      phone: _phoneFormatter.getUnmaskedText(), 
      addressStreet: _addressStreetController.text, 
      addressNumber: _addressNumberController.text, 
      addressNeighborhood: _addressNeighborhoodController.text,
      addressCity: _addressCityController.text, 
      addressState: _addressStateController.text, 
      addressCep: _addressCepController.text, 
      password: _passwordController.text,
    );

    final response = await professionalService.createProfessional(data, _selectedImage!);

    if(response != null && response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final professionalId = data['id'];

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage(professionalId)),
      );
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
                          if (value == null || value.isEmpty) return 'Preencha este campo';
                          if (value.length != 10) return 'Formato DD/MM/AAAA';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _emailController,
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Preencha este campo';
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),
                      _buildImagePicker(),
                      _buildTextFormField(
                        controller: _phoneController,
                        label: 'Número de telefone',
                        inputFormatters: [_phoneFormatter],
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Preencha este campo';
                          if (value.length < 14) return 'Telefone incompleto';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _documentController,
                        label: 'CPF/CNPJ',
                        // inputFormatters: [_cnpjFormatter],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Preencha este campo';
                          // if (value.length != 14) return 'CNPJ incompleto';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _addressStreetController,
                        label: 'Rua',
                      ),
                      _buildTextFormField(
                        controller: _addressNeighborhoodController,
                        label: 'Bairro',
                      ),
                       _buildTextFormField(
                        controller: _addressNumberController,
                        label: 'Número',
                      ),                   
                      _buildTextFormField(
                        controller: _addressCepController,
                        label: 'CEP',
                      ),                      
                      _buildTextFormField(
                        controller: _addressCityController,
                        label: 'Cidade',
                      ),                      
                      _buildTextFormField(
                        controller: _addressStateController,
                        label: 'Estado',
                      ),
                      _buildTextFormField(
                        controller: _passwordController,
                        label: 'Senha',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Preencha este campo';
                          if (value.length < 6) return 'Mínimo de 6 caracteres';
                          return null;
                        },
                      ),
                      _buildTextFormField(
                        controller: _confirmPasswordController,
                        label: 'Confirme sua senha',
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Preencha este campo';
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
                              _createProfessional();
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

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto de Perfil',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              setState(() {
                _selectedImage = File(pickedFile.path);
              });
            }
          },
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: _selectedImage == null
                ? const Center(
                    child: Text(
                      'Toque para selecionar uma imagem',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
          ),
        ),
        if (_imageError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Selecione uma foto de perfil',
              style: TextStyle(color: Colors.red[700], fontSize: 12),
            ),
          ),
      ],
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
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off, color: Color(0xFF737373))
              : null,
        ),
        validator: validator ??
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
