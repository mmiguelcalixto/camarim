import 'package:flutter/material.dart';
import 'hire_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/professional.dart';
import '../services/professional.service.dart';

class ProfessionalPageClient extends StatefulWidget {
  final int professionalId;

  const ProfessionalPageClient({super.key, required this.professionalId});

  @override
  State<ProfessionalPageClient> createState() => _ProfessionalPageClientState();
}

class _ProfessionalPageClientState extends State<ProfessionalPageClient> {
  late Future<Professional> _futureProfessional;
  final ProfessionalService _service = ProfessionalService();

  @override
  void initState() {
    super.initState();
    _futureProfessional = _service.getProfessionalById(widget.professionalId);
  }

  // FUNÇÃO AUXILIAR PARA IMAGENS DE TRABALHO
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

  // FUNÇÃO AUXILIAR PARA MÍDIAS SOCIAIS
  Widget _buildSocialMediaRow(List<String> links, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: links.map((link) {
        IconData iconData;
        String linkText;

        if (link.contains('instagram.com')) {
          iconData = FontAwesomeIcons.instagram;
          linkText = "Link do Instagram";
        } else if (link.contains('linkedin.com')) {
          iconData = FontAwesomeIcons.linkedin;
          linkText = "Link do Linkedin";
        } else if (link.contains('tiktok.com')) {
          iconData = FontAwesomeIcons.tiktok;
          linkText = "Link do TikTok";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Professional>(
        future: _futureProfessional,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar o perfil: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Profissional não encontrado.'));
          }

          final professional = snapshot.data!;

          return SafeArea(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 211, 203, 234),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // FOTO DE PERFIL
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(professional.profileImageUrl),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // NOME E BIO
                    Center(
                      child: Text(
                        professional.name,
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
                        '${professional.email}\n${professional.phone}',
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
                    const SizedBox(height: 20),

                    // TRABALHOS JÁ FEITOS
                    const Text("Trabalhos já Feitos", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 92, 98, 158))),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Text("O portfólio deste profissional ainda não foi cadastrado.", style: TextStyle(color: Colors.grey.shade600)),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildWorkImage(professional.profileImageUrl),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // SERVIÇOS
                const Text("Serviços", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 92, 98, 158))),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Chip(label: Text("Informações de serviços em breve")),
                    ),
                    const SizedBox(height: 20),

                    // TRAJETÓRIA
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

                    // MÍDIAS SOCIAIS
                    const Text(
                      "Mídias Sociais",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 92, 98, 158),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildSocialMediaRow(
                        [], // no social media links available on Professional model
                        const Color.fromARGB(255, 92, 98, 158)),
                    const SizedBox(height: 30),
                  ],
                ),

                // Botão de voltar
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color.fromARGB(255, 92, 98, 158), size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
