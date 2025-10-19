import 'package:flutter/material.dart';
import 'hire_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/professional_profile.dart';
import '../services/professional.service.dart';

class ProfessionalPageClient extends StatefulWidget {
  final int professionalId;

  const ProfessionalPageClient({super.key, required this.professionalId});

  @override
  State<ProfessionalPageClient> createState() => _ProfessionalPageClientState();
}

class _ProfessionalPageClientState extends State<ProfessionalPageClient> {
late Future<ProfessionalProfile> _futureProfile;
  final ProfessionalService _service = ProfessionalService();

  @override
  void initState() {
    super.initState();
    _futureProfile = _service.getProfessionalById(widget.professionalId);
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
    body: FutureBuilder<ProfessionalProfile>(
      future: _futureProfile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar o perfil: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('Profissional não encontrado.'));
        }

        final profile = snapshot.data!;

        return SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16), 
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 211, 203, 234),
                      image: profile.headerImageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(profile.headerImageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(profile.profileImageUrl),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Center(
                    child: Text(
                      profile.name,
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
                      profile.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContratarPage())),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 92, 98, 158)),
                    child: const Text("Contratar",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),

                  const Text("Serviços",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 92, 98, 158))),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: profile.services.isNotEmpty
                        ? profile.services.map((service) {
                            return Chip(
                              label: Text(
                                  '${service.name} - R\$${service.price.toStringAsFixed(2)}'),
                            );
                          }).toList()
                        : [const Chip(label: Text("Nenhum serviço cadastrado"))],
                  ),
                  const SizedBox(height: 20),

                  const Text("Trabalhos já Feitos",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 92, 98, 158))),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: profile.workImages.isNotEmpty
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: profile.workImages
                                .map((imageUrl) => _buildWorkImage(imageUrl))
                                .toList(),
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: Text(
                                "O portfólio ainda não foi cadastrado.",
                                style: TextStyle(color: Colors.grey.shade600)),
                          ),
                  ),
                  const SizedBox(height: 20),
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

                  const Text("Mídias Sociais",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 92, 98, 158))),
                  const SizedBox(height: 10),
                  _buildSocialMediaRow(
                      profile.socialMediaLinks,
                      const Color.fromARGB(255, 92, 98, 158)),
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
                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)]
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