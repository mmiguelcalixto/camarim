import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search_prof.dart'; 
import 'page_perfil.dart'; 
import '../widgets/category_chip.dart';
import '../widgets/section.dart';
import '../widgets/square_card.dart';
import '../widgets/circle_card.dart';
import '../widgets/horizontal_list.dart';

class Professional {
  final String name;
  final String imagePath;

  Professional({required this.name, required this.imagePath});
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    SearchProfPage(),
    const Center(child: Text("Página de Horários")),
    ProfilePage(),
    const Center(child: Text("Página de Menu")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
          unselectedItemColor: Colors.deepPurple.withValues(),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: "Início",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
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
            )
          ],
        ),
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {

  // dados dos profissionais sugeridps
  final List<Professional> topRatedProfessionals = [
    Professional(name: 'Bruna Nails', imagePath: 'assets/img/nails.jpg'), 
    Professional(name: 'Gabriel Hair', imagePath: 'assets/img/gabriel.jpg'),
    Professional(name: 'Jorge SPA', imagePath: 'assets/img/jorge.jpg'), 
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF9FA0E4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/img/logo_camarim.png',
                      width: 150,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFFD3C5EA)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Pesquisar...",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFD3C5EA),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: PageView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/img/banner1.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/img/banner2.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/img/banner3.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                CategoryChip(
                  label: "Recentes",
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryChip(
                  label: "Patrocinados",
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryChip(
                  label: "Sugestões",
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryChip(
                  label: "Bem avaliados",
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryChip(
                  label: "Categorias",
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Section(
            title: "Serviços Recentes",
            child: HorizontalList(
              children: const [
                CircleCard("Jussy Makeup"),
                CircleCard("Mafê Nails"),
                CircleCard("Afonsa Cortes"),
              ],
            ),
          ),
          Section(
            title: "Bem avaliados",
            child: HorizontalList(
              children: topRatedProfessionals.map((prof) {
                return SquareCard(prof.name, prof.imagePath);
              }).toList(),
            ),
          ),
          Section(
            title: "Baseado nas suas escolhas",
            child: HorizontalList(
              children: const [
                CircleCard("Linda Make"),
                CircleCard("Jorge Hair"),
                CircleCard("Mary Nails"),
              ],
            ),
          ),
          Section(
            title: "Pertinho de você",
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giuliard",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ad minim veniam...",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
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
}