import 'dart:convert';
import 'dart:typed_data';
import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile_page.dart'; 

class ProfilePage extends StatefulWidget {
  final String professionalId;
  const ProfilePage(this.professionalId, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadProfessional();
  }

  Professional? professional;

  Future<void> _loadProfessional() async {
    final service = ProfessionalService();
    final result = await service.getProfessionalById(widget.professionalId);
    if (result != null) {
      final data = jsonDecode(result.body);

      print("$data ---------------------------------------------");
      setState(() {
        professional = Professional(
          id: data['id'],
          name: data['name'], 
          document: data['document'], 
          email: data['email'], 
          phone: data['phone'], 
          addressStreet: data['addressStreet'], 
          addressNumber: data['addressNumber'], 
          addressNeighborhood: data['addressNeighborhood'], 
          addressCity: data['addressCity'], 
          addressState: data['addressState'], 
          addressCep: data['addressCep'], 
          profileImage: data['profileImage'],
          averageRating: data['averageRating'],
        );
      });

      print("${professional?.profileImage} -----------------------------------------");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  professional?.profileImage?.replaceAll("localhost", "192.168.15.69") ?? "",
                ),
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // NOME E BIO
            Center(
              child: Text(
                professional?.name ?? "",
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
                "",
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
                "Alterar Perfil",
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
