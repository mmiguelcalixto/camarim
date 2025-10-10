import 'package:flutter/material.dart';

class EditMenuPage extends StatefulWidget {
  const EditMenuPage({super.key});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final TextEditingController _nomeController = TextEditingController(text: 'João');
  final TextEditingController _sobrenomeController = TextEditingController(text: 'Silva');
  final TextEditingController _telefoneController = TextEditingController(text: '(11) 98765-4321');
  final TextEditingController _enderecoController = TextEditingController(text: 'Rua das Flores, 123');
  final TextEditingController _emailController = TextEditingController(text: 'joao.silva@exemplo.com');

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    'Menu Principal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 92, 98, 158),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const _UsernameField(),
              const SizedBox(height: 20),
              Row(
                children: [
                  _CustomButton(icon: Icons.lock, label: 'Privacidade', onTap: () {}),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Meus Dados',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
color: Color.fromARGB(255, 92, 98, 158),                ),
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
              _EditableField(
                icon: Icons.home,
                controller: _enderecoController,
                hintText: 'Endereço',
              ),
              _EditableField(
                icon: Icons.email,
                controller: _emailController,
                hintText: 'E-mail',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              const _SaveDataButton(),
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

  const _EditableField({
    required this.icon,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
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
                keyboardType: keyboardType,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
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
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
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
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
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
  const _SaveDataButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 92, 98, 158);

    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
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
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.person, color: Colors.black),
          SizedBox(width: 10),
          Text(
            '@username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Spacer(),
          Icon(Icons.star, color: Color.fromARGB(255, 92, 98, 158)),
          SizedBox(width: 5),
          Text(
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
    return Container(
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
    );
  }
}
