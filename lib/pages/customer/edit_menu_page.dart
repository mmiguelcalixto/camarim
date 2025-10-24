import 'package:flutter/material.dart';
import 'package:camarim_backend/services/customer.service.dart';
import 'package:camarim_backend/models/customer_profile.dart';
import 'package:camarim_backend/models/customer_update_request.dart';
import 'package:camarim_backend/pages/privacy_policy_page.dart';

class EditMenuPage extends StatefulWidget {
  final CustomerProfile customerProfile;
  const EditMenuPage({super.key, required this.customerProfile});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final CustomerService _customerService = CustomerService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _enderecoRuaController = TextEditingController();
  final TextEditingController _enderecoNumeroController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final nomeCompleto = widget.customerProfile.fullName.split(' ');
    _nomeController.text = nomeCompleto.isNotEmpty ? nomeCompleto.first : '';
    _sobrenomeController.text = nomeCompleto.length > 1 ? nomeCompleto.sublist(1).join(' ') : '';

    _telefoneController.text = widget.customerProfile.phone;
    _enderecoRuaController.text = widget.customerProfile.addressStreet;
    _enderecoNumeroController.text = widget.customerProfile.addressNumber;
    _emailController.text = widget.customerProfile.email;
  }

  Future<void> _salvarAlteracoes() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    
    try {
      final request = CustomerUpdateRequest(
        fullName: '${_nomeController.text} ${_sobrenomeController.text}'.trim(),
        phone: _telefoneController.text,
        addressStreet: _enderecoRuaController.text,
        addressNumber: _enderecoNumeroController.text,
      );


      await _customerService.updateCustomer(widget.customerProfile.id, request);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      debugPrint('Erro ao salvar alterações: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar alterações.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _telefoneController.dispose();
    _enderecoRuaController.dispose();
    _enderecoNumeroController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 92, 98, 158);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'lib/assets/img/logo.png',
                          height: 40,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Editar Perfil',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _UsernameField(username: widget.customerProfile.username),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        _CustomButton(
                          icon: Icons.lock,
                          label: 'Privacidade',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPolicyPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Meus Dados',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _EditableMultiField(
                      icon: Icons.person,
                      controller1: _nomeController,
                      hintText1: 'Nome',
                      controller2: _sobrenomeController,
                      hintText2: 'Sobrenome',
                    ),
                    _EditableField(
                      icon: Icons.phone,
                      controller: _telefoneController,
                      hintText: 'Telefone',
                      keyboardType: TextInputType.phone,
                    ),
                    _EditableMultiField(
                      icon: Icons.home,
                      controller1: _enderecoRuaController,
                      hintText1: 'Rua',
                      controller2: _enderecoNumeroController,
                      hintText2: 'Número',
                    ),
                    _EditableField(
                      icon: Icons.email,
                      controller: _emailController,
                      hintText: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      enabled: false,
                    ),

                    const SizedBox(height: 20),

 
                    _SaveDataButton(
                      onTap: _isLoading ? null : _salvarAlteracoes,
                      isLoading: _isLoading,
                    ),

                    const SizedBox(height: 40),

                    const _LogoutButton(),
                  ],
                ),
              ),
            ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool enabled;

  const _EditableField({
    required this.icon,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: enabled ? Colors.grey[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 92, 98, 158),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: enabled,
                keyboardType: keyboardType,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
                validator: (value) {
                  if (enabled && (value == null || value.isEmpty)) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditableMultiField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller1;
  final String hintText1;
  final TextEditingController controller2;
  final String hintText2;

  const _EditableMultiField({
    required this.icon,
    required this.controller1,
    required this.hintText1,
    required this.controller2,
    required this.hintText2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 92, 98, 158),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: controller1,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: hintText1,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextFormField(
                  controller: controller2,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: hintText2,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveDataButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLoading;
  const _SaveDataButton({Key? key, required this.onTap, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 92, 98, 158);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Salvar Dados',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

class _UsernameField extends StatelessWidget {
  final String username;
  const _UsernameField({required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.black),
          const SizedBox(width: 10),
          Text(
            '@$username',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          const Icon(Icons.star, color: Color.fromARGB(255, 92, 98, 158)),
          const SizedBox(width: 5),
          const Text(
            '4.5',
            style: TextStyle(
              color: Color.fromARGB(255, 92, 98, 158),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _CustomButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30),
              const SizedBox(height: 5),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
          ],
        ),
      ),
    );
  }
}