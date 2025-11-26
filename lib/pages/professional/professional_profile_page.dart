import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:camarim_backend/services/professionalPortfolio.service.dart';
import 'package:camarim_backend/widgets/professional_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_professional_profile_page.dart'; 

class ProfessionalProfilePage extends StatefulWidget {
  final String professionalId;
  const ProfessionalProfilePage(this.professionalId, {super.key});

  @override
  State<ProfessionalProfilePage> createState() => _ProfessionalProfilePageState();
}

class _ProfessionalProfilePageState extends State<ProfessionalProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadProfessional();
  }

  Professional? professional;
  final List<Uint8List?> _userImages = List<Uint8List?>.filled(6, null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _loadProfessional() async {
    final prefs = await SharedPreferences.getInstance();
    
    final professionalId = prefs.getString('professionalId');

    if (professionalId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: ID do profissional não encontrado. Faça o login novamente.')),
        );
      }
      return;
    }

    final service = ProfessionalService();
    final result = await service.getProfessionalById(professionalId); 

    if (result != null) {
      final data = jsonDecode(result.body);
      setState(() {
        professional = Professional.fromJson(data);
      });
    }
  }

  void _showDeletePortfolioDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Gerenciar Portfólio',
            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _userImages.where((img) => img != null).length,
              itemBuilder: (context, index) {
                final nonNullImages = _userImages
                    .asMap()
                    .entries
                    .where((entry) => entry.value != null)
                    .toList();
                
                if (index >= nonNullImages.length) return const SizedBox.shrink();
                
                final imageEntry = nonNullImages[index];
                final imageBytes = imageEntry.value!;
                final originalIndex = imageEntry.key;

                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmar exclusão'),
                                content: const Text(
                                  'Deseja realmente excluir esta foto do portfólio?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: const Text('Excluir'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirm == true) {
                            final service = ProfessionalPortfolioService();
                            
                            // Aqui você deve chamar o método do serviço para excluir
                            // Exemplo: await service.deleteImageFromPortfolio(professional!.id!, imageId);
                            
                            setState(() {
                              _userImages[originalIndex] = null;
                            });

                            Navigator.of(context).pop();
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Foto excluída com sucesso!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
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

            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  professional?.profileImage?.replaceAll("localhost", "192.168.15.69") ?? "",
                ),
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

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
            Center(
              child: Text(
                professional?.description ?? "",
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfessionalProfessionalProfilePage(professional!.id!),
                  ),
                );

                if (updated == true) {
                  await _loadProfessional();
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text(
                "Alterar Perfil",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: _showDeletePortfolioDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Gerenciar Fotos do Portfólio",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            _buildLatestWorks(),

            const Text(
              "Serviços",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Wrap(
              spacing: 8,
              children: (professional?.services?.isNotEmpty ?? false)
                  ? professional!.services!
                      .map((s) => Chip(label: Text(s.name)))
                      .toList()
                  : [const Text('Nenhum serviço cadastrado')],
            ),
            
            const SizedBox(height: 20),

            const Text(
              "Endereço",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 130,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rua ${professional?.addressStreet}, ${professional?.addressNumber}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Bairro ${professional?.addressNeighborhood}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${professional?.addressCity} - ${professional?.addressState}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: ProfessionalBottomNavBar(professionalId: widget.professionalId, currentIndex: 1),
    );
  }

  Widget _buildLatestWorks() {
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
                  onTap: () async {
                    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      final bytes = await pickedFile.readAsBytes();
                      setState(() {
                        _userImages[index] = bytes;
                      });

                      final service = ProfessionalPortfolioService();
                      
                      await service.addImageToPortfolio(professional!.id!, File(pickedFile.path));
                    }
                  },
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
