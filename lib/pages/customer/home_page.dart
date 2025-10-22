import 'package:camarim_backend/pages/customer/horarios_page.dart';
import 'package:camarim_backend/pages/customer/menu_page.dart';  
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search_prof.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/section.dart';
import '../../widgets/circle_card.dart';
import '../../widgets/horizontal_list.dart';

class HomePage extends StatefulWidget {
  final String customerId;

  const HomePage(this.customerId, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    SearchProfPage(),
    HorariosPage(),
    MenuPage(),
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
            color: const Color.fromARGB(255, 92, 98, 158),
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
          selectedItemColor: const Color.fromARGB(255, 92, 98, 158),
          unselectedItemColor: const Color.fromARGB(255, 92, 98, 158),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: "Início",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: "Busca",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendar),
              label: "Horários",
            ),
            //  BottomNavigationBarItem(
            //   icon: FaIcon(FontAwesomeIcons.user),
            //   label: "Perfil",
            // ),
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

// FIM DA NAV BAR ----------------------------------------------------------------

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {

  // final List<Professional> topRatedProfessionals = [
  //   Professional(name: 'Bruna Nails', imagePath: 'lib/assets/img/nails.jpg'),
  //   Professional(name: 'Gabriel Hair', imagePath: 'lib/assets/img/gabriel.jpg'),
  //   Professional(name: 'Jorge SPA', imagePath: 'lib/assets/img/jorge.jpg'),
  // ];

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
                      'lib/assets/img/logo_camarim.png',
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
                      'lib/assets/img/banner1.png',
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
                      'lib/assets/img/banner2.png',
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
                      'lib/assets/img/banner3.png',
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
                  label: "Bem avaliados",
                  isSelected: false,
                  onTap: () {},
                ),
                CategoryChip(
                  label: "Por Localização",
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Section(
          //   title: "Bem avaliados",
          //   child: HorizontalList(
          //     children: topRatedProfessionals.map((prof) {
          //       return SquareCard(prof.name, prof.imagePath);
          //     }).toList(),
          //   ),
          // ),
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