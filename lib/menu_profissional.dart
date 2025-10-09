import 'package:flutter/material.dart';

// Definindo as cores base inspiradas na imagem
const Color kPrimaryColor = Color.fromARGB(255, 68, 77, 137); // Roxo/Índigo forte
const Color kFieldBackgroundColor = Color(0xFFEFEFEF); // Cinza/Bege claro

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 3; // Índice para 'Menu' na BottomNavBar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Aqui você adicionaria a lógica de navegação real para cada item do menu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Aumentei um pouco o padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Logo "camarim")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30), // Espaço para o topo
                  // Mantendo o Image.asset, mas o substituindo por um Text estilizado
                  // se o asset não estiver disponível, para simular o estilo do logo.
                  Image.asset(
                    'lib/assets/img/logo.png',
                    height: 40,
                    errorBuilder: (context, error, stackTrace) => const Text(
                      'camarim',
                      style: TextStyle(
                        fontFamily: 'Montserrat', // Fontes customizadas trariam o estilo exato
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  // O texto 'Menu Principal' do código original foi removido,
                  // como na imagem de referência.
                ],
              ),
              const SizedBox(height: 25),

              // 2. Campo Username
              const _UsernameField(),
              const SizedBox(height: 15),

              // 3. Botões de Ação Rápida (Carteira e Privacidade)
              const Row(
                children: [
                  _CustomButton(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'carteira',
                    // onTap: () {}, // Removido para simplificação
                  ),
                  SizedBox(width: 15),
                  _CustomButton(
                    icon: Icons.shield_outlined,
                    label: 'privacidade',
                    // onTap: () {}, // Removido para simplificação
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 4. Título da Seção "Meus Dados"
              const Text(
                'Meus Dados',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor, // Usando a cor primária
                ),
              ),
              const SizedBox(height: 10),

              // 5. Campos de Dados do Estabelecimento
              const _PersonalDataField(
                icon: Icons.person,
                label: 'Nome do Estabelecimento', // Alterado de Nome/Sobrenome
              ),
              const _PersonalDataField(
                icon: Icons.phone,
                label: 'Telefone',
              ),
              const _PersonalDataField(
                icon: Icons.home,
                label: 'CNPJ', // Alterado de Endereço
              ),
              const _PersonalDataField(
                icon: Icons.email,
                label: 'E-mail',
              ),
              const SizedBox(height: 20),

              // 6. Botão Editar Dados
              const _EditDataButton(),
              const SizedBox(height: 30),

              // 7. Botão Logout
              const _LogoutButton(),
              const SizedBox(height: 60), // Espaço extra para a BottomNavBar
            ],
          ),
        ),
      ),
      // 8. Bottom Navigation Bar
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// --- Componentes Reutilizáveis Atualizados ---

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: kFieldBackgroundColor, // Fundo claro da imagem
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: Colors.black54),
          const SizedBox(width: 10),
          const Text(
            '@username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          // Icone de Estrela e Avaliação
          Icon(Icons.star, color: kPrimaryColor), // Cor primária
          const SizedBox(width: 5),
          Text(
            '4.5',
            style: TextStyle(
              color: kPrimaryColor,
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
  // O onTap original foi mantido como opcional.
  final VoidCallback? onTap;

  const _CustomButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 90, // Aumentei um pouco a altura para ficar mais quadrado/imponente
          decoration: BoxDecoration(
            color: kFieldBackgroundColor, // Fundo claro da imagem
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 35, color: kPrimaryColor),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonalDataField extends StatelessWidget {
  final IconData icon;
  final String label;

  // Simplificado para campos simples (não multi-field) conforme a imagem
  const _PersonalDataField({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 55, // Altura padronizada
        decoration: BoxDecoration(
          color: kFieldBackgroundColor, // Fundo claro
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Bloco de ícone na cor primária
            Container(
              height: 55, // Combina com a altura do Container pai
              width: 50,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 15),
            // Label do campo
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditDataButton extends StatelessWidget {
  const _EditDataButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: kFieldBackgroundColor, // Fundo claro da imagem
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: kFieldBackgroundColor, // Fundo claro da imagem
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
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

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Transparente para usar o container
        elevation: 0, // Remove a sombra padrão do BottomNavBar
        type: BottomNavigationBarType.fixed, // Permite 5 itens
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Hours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}