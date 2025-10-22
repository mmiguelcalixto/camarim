import 'package:camarim_backend/pages/professional/prof_horarios_page.dart';
import 'package:camarim_backend/pages/professional/professional_menu_page.dart';
import 'package:camarim_backend/pages/professional/professional_profile_page.dart';
import 'package:flutter/material.dart';

class ProfessionalBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final String professionalId;

  const ProfessionalBottomNavBar({
    super.key,
    required this.professionalId,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = ProfHorariosPage(professionalId);
        break;
      case 1:
        page =  ProfessionalProfilePage(professionalId);
        break;
      case 2:
        page = ProfessionalMenuPage(professionalId);
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.deepPurple,
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Horários",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: "Menu",
        ),
      ],
    );
  }
}
