import 'dart:typed_data';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Uint8List? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _profileImage = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar Dados",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // IMAGEM DE PERFIL
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: _profileImage != null
                      ? MemoryImage(_profileImage!)
                      : const AssetImage("assets/images/perfil.png")
                          as ImageProvider,
                  backgroundColor: Colors.grey[300],
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // INPUTS
          const TextField(
            decoration: InputDecoration(
              labelText: "Nome",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: "Biografia",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: "Serviços Prestados",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: "Redes Sociais",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: "Número de Contato",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: "Endereço",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),

          // BOTÃO SALVAR
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Dados salvos com sucesso!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              side: const BorderSide(color: Colors.deepPurple, width: 1.5),
            ),
            child: const Text("Salvar Alterações"),
          ),
        ],
      ),

      // NAVBAR IGUAL NAS OUTRAS TELAS
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
          unselectedItemColor: Colors.deepPurple,
          currentIndex: 3,
          onTap: (index) {
            Navigator.pop(context);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Início",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Pesquisa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Horários",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Menu",
            ),
          ],
        ),
      ),
    );
  }
}