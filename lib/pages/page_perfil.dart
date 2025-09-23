import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile_page.dart'; 

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/header.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // FOTO DE PERFIL
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/perfil.png"),
              backgroundColor: Colors.white,
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

          // BOTÃO EDITAR BIOGRAFIA
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text(
              "Alterar Biografia",
              style: TextStyle(color: Colors.white),
            ),
          ),

          // TRABALHOS RECENTES
          const LatestWorks(),

          // SERVIÇOS
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

          // TRAJETÓRIA
          const Text(
            "Trajetória",
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
                    child: Text("Adicionar instituição\nO que você aprendeu?"),
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
                    child: Text("Detalhes da instituição..."),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // DIFERENCIAIS
          const Text(
            "Diferenciais",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "✦ Este profissional atende a domicílio",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Text(
            "✦ Este profissional oferece atendimento adaptado a pessoas neurodivergentes",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),

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

          // MÍDIAS SOCIAIS
          const Text(
            "Mídias Sociais",
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
                  Text("Seu link do Instagram"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.linkedin, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Text("Seu link do LinkedIn"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.tiktok, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Text("Seu link do TikTok"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.xTwitter, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Text("Seu link do X"),
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
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
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
              if (index < 2) {
                // Imagens padrão para os dois primeiros slots
                return _buildDefaultAsset("assets/images/work${index + 1}.png");
              } else {
                final imageBytes = _userImages[index];
                if (imageBytes != null) {
                  return _buildUserImage(imageBytes);
                }
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
              }
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

  Widget _buildUserImage(Uint8List imageBytes) {
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
        ),
      ),
    );
  }
}