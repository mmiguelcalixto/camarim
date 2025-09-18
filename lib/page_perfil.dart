import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Importe as outras páginas que você vai exibir quando o usuário tocar nos ícones
// import 'outra_pagina.dart'; 

// A classe agora é um StatefulWidget para gerenciar o estado da barra de navegação
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // O índice 4 corresponde ao "Menu" na barra de navegação
  int _selectedIndex = 4;

  // Lista de widgets para cada item da barra de navegação
  final List<Widget> _pages = const [
    Center(child: Text("Início")),
    Center(child: Text("Pesquisa")),
    Center(child: Text("Horários")),
    Center(child: Text("Perfil")),
    // Esta é a própria página de menu que estamos construindo
    _MenuContent(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Exibe a página selecionada
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FF),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: Colors.deepPurple,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.deepPurple.withOpacity(0.5),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: "Início",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: "Pesquisa",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendar),
              label: "Horários",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "Perfil",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bars),
              label: "Menu",
            ),
          ],
        ),
      ),
    );
  }
}

// Widget auxiliar para o conteúdo da página de menu
class _MenuContent extends StatelessWidget {
  const _MenuContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Menu Principal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const UsernameField(),
            const SizedBox(height: 20),
            Row(
              children: [
                CustomButton(
                  icon: Icons.star,
                  label: 'Favoritos',
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                CustomButton(
                  icon: Icons.lock,
                  label: 'Privacidade',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Meus Dados',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 10),
            PersonalDataField(
              icon: Icons.person,
              label: 'Nome',
              isMultiField: true,
              secondLabel: 'Sobrenome',
            ),
            PersonalDataField(
              icon: Icons.phone,
              label: 'Telefone',
            ),
            PersonalDataField(
              icon: Icons.home,
              label: 'Endereço',
            ),
            PersonalDataField(
              icon: Icons.email,
              label: 'E-mail',
            ),
            const SizedBox(height: 20),
            const EditDataButton(),
            const SizedBox(height: 40),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}

// O resto dos widgets auxiliares (UsernameField, CustomButton, PersonalDataField, etc.)
// ... (mantenha todo o código desses widgets que já criamos)

// Widget para o campo de username
class UsernameField extends StatelessWidget {
  const UsernameField({super.key});

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
          Icon(Icons.star, color: Colors.deepPurple),
          SizedBox(width: 5),
          Text(
            '4.5',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget de botão personalizado para a página de menu
class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CustomButton({
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

// Widget para os campos de dados pessoais com o ícone roxo
class PersonalDataField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isMultiField;
  final String? secondLabel;

  const PersonalDataField({
    Key? key,
    required this.icon,
    required this.label,
    this.isMultiField = false,
    this.secondLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container do campo de dados completo
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isMultiField
          ? Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // Container do ícone com fundo roxo para o campo "Nome"
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Icon(icon, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            label,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        secondLabel!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.all(0),
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
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(label, style: const TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
    );
  }
}

// Widget para o botão "Editar Dados"
class EditDataButton extends StatelessWidget {
  const EditDataButton({Key? key}) : super(key: key);

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
            'Editar Dados',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

// Widget para o botão "Logout" com a mesma estrutura de "Editar Dados"
class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

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