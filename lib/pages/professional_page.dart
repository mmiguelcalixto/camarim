import 'package:flutter/material.dart';
import 'hire_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camarim_backend/models/professional_profile.dart';

class ProfessionalPageClient extends StatelessWidget {
  const ProfessionalPageClient({super.key});

  @override
  Widget build(BuildContext context) {
    // simula dados de um profissional. é so puxar o back-end pra isso, isso é so um modelo de como deve ser apresentado
    final ProfessionalProfile mockProfile = ProfessionalProfile(
      profileImageUrl: "lib/assets/img/perfil.png",
      headerImageUrl: "lib/assets/img/header.png",
      name: "Laura Nails Hair",
      bio: "Sou formada pelo Instituto L'Oréal BH e atuo na área há mais de 10 anos.\nVeja meu trabalho e se surpreenda :)",
      socialMediaLinks: [
        "https://www.instagram.com/lauranailshair",
        "https://www.linkedin.com/in/lauranailshair",
        "https://www.tiktok.com/@lauranailshair",
        "https://twitter.com/lauranailshair",
      ],
      services: [
        "Unhas de gel",
        "Manicure/Pedicure",
        "Corte",
        "Descoloração Profissional",
        "Tons Fantasia"
      ],
      workImages: [
        "lib/assets/img/woman_makeup.png",
        "lib/assets/img/jorge.jpg",
        "lib/assets/img/woman_splash.png"
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // HEADER
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(mockProfile.headerImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // FOTO DE PERFIL
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(mockProfile.profileImageUrl),
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // NOME E BIO
                Center(
                  child: Text(
                    mockProfile.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 92, 98, 158),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    mockProfile.bio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 12),

                // BOTÃO CONTRATAR
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContratarPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 92, 98, 158),
                  ),
                  child: const Text(
                    "Contratar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),

                // TRABALHOS JÁ FEITOS
                const Text(
                  "Trabalhos já Feitos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 92, 98, 158),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: mockProfile.workImages
                        .map((url) => _buildWorkImage(url))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),

                // SERVIÇOS
                const Text(
                  "Serviços",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 92, 98, 158),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: mockProfile.services
                      .map((service) => Chip(label: Text(service)))
                      .toList(),
                ),
                const SizedBox(height: 20),

                // TRAJETÓRIA, DIFERENCIAIS E MAPA
                const Text(
                  "Trajetória",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 92, 98, 158),
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
                          child: Text("Instituição de ensino \nO que aprendi"),
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
                    color: Color.fromARGB(255, 92, 98, 158),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "✦ Este profissional atende a domicílio",
                  style: TextStyle(
                    color: Color.fromARGB(255, 92, 98, 158),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "✦ Este profissional oferece atendimento adaptado a pessoas neurodivergentes",
                  style: TextStyle(
                    color: Color.fromARGB(255, 92, 98, 158),
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
                      image: AssetImage("lib/assets/img/maps.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Mídias Sociais",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 92, 98, 158),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSocialMediaRow(
                    mockProfile.socialMediaLinks, const Color.fromARGB(255, 92, 98, 158)),
                const SizedBox(height: 30),
              ],
            ),

            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 92, 98, 158), size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkImage(String imageUrl) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: imageUrl.startsWith('http')
              ? NetworkImage(imageUrl) as ImageProvider
              : AssetImage(imageUrl) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSocialMediaRow(List<String> links, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: links.map((link) {
        IconData iconData;
        String linkText;

        if (link.contains('instagram.com')) {
          iconData = FontAwesomeIcons.instagram;
          linkText = "Link do instagram";
        } else if (link.contains('linkedin.com')) {
          iconData = FontAwesomeIcons.linkedin;
          linkText = "Link do linkedin";
        } else if (link.contains('tiktok.com')) {
          iconData = FontAwesomeIcons.tiktok;
          linkText = "Link do tiktoi";
        } else if (link.contains('twitter.com') || link.contains('x.com')) {
          iconData = FontAwesomeIcons.xTwitter;
          linkText = "Link do X";
        } else {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              FaIcon(iconData, color: color),
              const SizedBox(width: 8),
              Text(linkText),
            ],
          ),
        );
      }).toList(),
    );
  }
}