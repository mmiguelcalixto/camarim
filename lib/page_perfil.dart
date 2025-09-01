import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile_page.dart';


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
    Center(child: Text("Início")),
    Center(child: Text("Pesquisa")),
    Center(child: Text("Horários")),
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // HEADER
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

          // BOTÃO EDIT BIO
           ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
  },
  child: const Text("Alterar Biografia"),
),

          // LATEST WORKS
          const LatestWorks(),

          // SERVICES
          const Text(
            "Serviços",
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
            "Tragetória",
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

          

         Text(
  "✦ Este profissional atende a domicílio",
  style: TextStyle(
    color: Colors.deepPurple, 
    fontWeight: FontWeight.bold,
    fontSize: 16, 
  ),
),
 Text(
  "✦ Este profissional oferece atendimento adaptado a pessoas neurodivergentes",
  style: TextStyle(
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),


          // MAPA
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
    Row(
      children: [
        FaIcon(FontAwesomeIcons.instagram, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("your instagram link"),
      ],
    ),
    SizedBox(height: 8),
    Row(
      children: [
        FaIcon(FontAwesomeIcons.linkedin, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("your linkedin link"),
      ],
    ),
    SizedBox(height: 8),
    Row(
      children: [
        FaIcon(FontAwesomeIcons.tiktok, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("your tiktok link"),
      ],
    ),
    SizedBox(height: 8),
    Row(
      children: [
        FaIcon(FontAwesomeIcons.xTwitter, color: Colors.deepPurple),
        SizedBox(width: 8),
        Text("your X link"),
      ],
    ),
  ],
),
const SizedBox(height: 30),

        ],
      ),
    );
  }
}

class LatestWorks extends StatefulWidget {
  const LatestWorks({super.key});

  @override
  State<LatestWorks> createState() => _LatestWorksState();
}

class _LatestWorksState extends State<LatestWorks> {
  final List<Uint8List?> _userImages = List<Uint8List?>.filled(6, null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _userImages[index] = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trabalhos já Feitos",
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
              final imageBytes = _userImages[index];

              if (imageBytes != null) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                );
              }

              // imagens padrão
              if (index == 0) {
                return _buildDefaultAsset("assets/images/work1.png");
              } else if (index == 1) {
                return _buildDefaultAsset("assets/images/work2.png");
              }

              // botão para adicionar
              return GestureDetector(
                onTap: () => _pickImage(index),
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.add, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDefaultAsset(String path) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
