import 'package:camarim_backend/pages/horarios_page.dart';
import 'package:camarim_backend/pages/menu_page.dart';  
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search_prof.dart';
import 'package:camarim_backend/pages/professional_page.dart';
import '../widgets/category_chip.dart';
import '../widgets/section.dart';
import '../widgets/square_card.dart';
import '../widgets/circle_card.dart';
import '../widgets/horizontal_list.dart';
import '../models/professional.dart'; 
import '../services/professional.service.dart';

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
    HorariosPage(),
    //const Center(child: Text("Página do Perfil do Cliente")),
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

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}


class _HomePageContentState extends State<HomePageContent> {
  late Future<List<Professional>> _futureProfessionals;
  final ProfessionalService _professionalService = ProfessionalService();

  @override
  void initState() {
    super.initState();
    _futureProfessionals = _professionalService.getProfessionals();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Professional>>(
     future: _futureProfessionals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar dados: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Nenhum profissional foi encontrado"));
        }
        
        final professionals = snapshot.data!;
        final firstProfessional = professionals.first;

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
Section(
                title: "Bem avaliados",
                child: HorizontalList(
                  children: professionals.map((prof) {
                    return GestureDetector(
                      onTap: () {
                        print('Clicou em (SquareCard): ${prof.name} com ID: ${prof.id}'); 
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfessionalPageClient(professionalId: prof.id), 
                          ),
                        );
                      },
                      child: SquareCard(prof.name, prof.profileImageUrl),
                    );
                  }).toList(),
                ),
              ),

              Section(
                title: "Baseado nas suas escolhas",
                child: HorizontalList(
                  children: professionals.map((prof) {
                    return GestureDetector(
                      onTap: () {
                        print('Clicou em (CircleCard): ${prof.name} com ID: ${prof.id}'); 
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfessionalPageClient(professionalId: prof.id), 
                          ),
                        );
                      },
                      child: CircleCard(prof.name),
                    );
                  }).toList(),
                ),
              ),

              Section(
                title: "Pertinho de você",
                child: GestureDetector(
                  onTap: () {
                    print('Clicou em (Destaque): ${firstProfessional.name} com ID: ${firstProfessional.id}'); 
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfessionalPageClient(professionalId: firstProfessional.id), 
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              firstProfessional.profileImageUrl,
                              width: 80, height: 80, fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(width: 80, height: 80, color: Colors.grey, child: const Icon(Icons.person, color: Colors.white));
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  firstProfessional.name, 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Especialista em ${firstProfessional.addressCity}",
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
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}