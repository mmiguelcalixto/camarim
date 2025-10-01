// Arquivo: lib/home_page.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'schedule_page.dart'; // Sua página de horários

// Placeholder para as outras 4 abas, já que o foco é na SchedulePage.
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Índice 2 é "Hours" (0=Home, 1=Search, 2=Hours)
  // Eu mudei o índice inicial para 2 para que a tela de horários apareça ao iniciar.
  int _selectedIndex = 2; 

  final List<Widget> _pages = const [
    PlaceholderPage("Home"),
    PlaceholderPage("Search"),
    
    // ⭐️ A PÁGINA DE AGENDAMENTO DE HORÁRIOS ESTÁ AQUI (Índice 2)
    SchedulePage(),
    
    PlaceholderPage("Profile"),
    PlaceholderPage("Menu"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exibe a página selecionada
      body: _pages[_selectedIndex],
      
      // ⭐️ SUA BARRA DE NAVEGAÇÃO CUSTOMIZADA ⭐️
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FF),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: Colors.deepPurple, // borda roxa
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
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendar),
              label: "Hours",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "Profile",
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