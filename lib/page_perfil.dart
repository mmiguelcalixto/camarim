import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Profissional',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 3; // começa na aba Profile

  final List<Widget> _pages = const [
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Hours")),
    ProfilePage(),
    Center(child: Text("Menu")),
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // HEADER COM IMAGEM
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image: const DecorationImage(
                image: AssetImage("assets/images/header.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // FOTO DE PERFIL
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage("assets/images/perfil.png"),
              backgroundColor: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 12),

          // NOME E BIO
          const Center(
            child: Text(
              "Laura Nails & Hair",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Sou formada pelo Instituto L'Oréal BH e atuo na área há mais de 10 anos.\nVeja meu trabalho e se surpreenda :)",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 12),

          // BOTÃO EDIT BIOGRAPHY
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text(
              "Edit biography",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // LATEST WORKS
          const Text(
            "latest works",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/work1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else if (index == 1) {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/work2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, color: Colors.grey),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),

          // SERVICES
          const Text(
            "services",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Wrap(
            spacing: 8,
            children: [
              Chip(label: Text("Unhas de gel")),
              Chip(label: Text("Manicure/Pedicure")),
              Chip(label: Text("Corte")),
              Chip(label: Text("Tintura")),
              Chip(label: Text("Descoloração")),
              Chip(label: Text("Tons Fantasia")),
              Chip(label: Text("Loiros")),
              Chip(label: Text("Maquiagem")),
              Chip(label: Text("Add service +")),
            ],
          ),
          const SizedBox(height: 20),

          // CAREER
          const Text(
            "career",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text("Add an institution\nWhat do you learn?"),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text("Institution details timeline..."),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // DIFERENCIAIS
          const Text("✦ Este profissional atende a domicílio"),
          const Text("✦ Add another differential +"),
          const SizedBox(height: 20),

          // LOCATION / MAPA
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage("assets/images/maps.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // SOCIAL MEDIA
          const Text(
            "social medias",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("📸 your instagram link"),
              Text("💼 your linkedin link"),
              Text("🎵 your tiktok link"),
              Text("🐦 your X link"),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
