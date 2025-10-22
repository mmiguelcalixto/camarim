import 'dart:convert';
import 'dart:io';
import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfessionalProfessionalProfilePage extends StatefulWidget {
  final String professionalId;
  const EditProfessionalProfessionalProfilePage(this.professionalId, {super.key});

  @override
  State<EditProfessionalProfessionalProfilePage> createState() => _EditProfessionalProfessionalProfilePageState();
}

class _EditProfessionalProfessionalProfilePageState extends State<EditProfessionalProfessionalProfilePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _servicesController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _documentController = TextEditingController();
  final _addressStreetController = TextEditingController();
  final _addressNumberController = TextEditingController();
  final _addressNeighborhoodController = TextEditingController();
  final _addressCityController = TextEditingController();
  final _addressStateController = TextEditingController();
  final _addressCepController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadProfessional();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _servicesController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _addressStreetController.dispose();
    _addressNumberController.dispose();
    _addressNeighborhoodController.dispose();
    _addressCityController.dispose();
    _addressStateController.dispose();
    _addressCepController.dispose();
    super.dispose();
  }

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  Professional? professional;
  final service = ProfessionalService();

  Future<void> _loadProfessional() async {
    final result = await service.getProfessionalById(widget.professionalId);
    if (result != null) {
      final data = jsonDecode(result.body);

      setState(() {
        professional = Professional.fromJson(data);

        _nameController.text = professional!.name;
        _descriptionController.text = professional!.description ?? "";
        _emailController.text = professional!.email;
        _phoneController.text = professional!.phone;
        _documentController.text = professional!.document;
        _addressStreetController.text = professional!.addressStreet;
        _addressNumberController.text = professional!.addressNumber;
        _addressNeighborhoodController.text = professional!.addressNeighborhood;
        _addressCityController.text = professional!.addressCity;
        _addressStateController.text = professional!.addressState;
        _addressCepController.text = professional!.addressCep;

      });
    }
  }
  
  Future<void> _editProfessional() async {
    final professionalToEdit = Professional(
      name: _nameController.text, 
      document: _documentController.text, 
      email: _emailController.text, 
      phone: _phoneController.text, 
      addressStreet: _addressStreetController.text, 
      addressNumber: _addressNumberController.text, 
      addressNeighborhood: _addressNeighborhoodController.text, 
      addressCity: _addressCityController.text, 
      addressState: _addressStateController.text, 
      addressCep: _addressCepController.text,
      description: _descriptionController.text,
    );

    final response = await service.updateProfessional(widget.professionalId, professionalToEdit, _profileImage);

    if (response != null && response.statusCode == 200) {
      if (!mounted) return;
      
      Navigator.pop(context, true);
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
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
                    ?  FileImage(_profileImage!)
                    : NetworkImage(
                      professional?.profileImage?.replaceAll("localhost", "192.168.15.69") ?? "",
                    ),
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
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Nome",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _servicesController,
            decoration: const InputDecoration(
              labelText: "Serviços Prestados",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressStreetController,
            decoration: const InputDecoration(
              labelText: "Rua",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressNumberController,
            decoration: const InputDecoration(
              labelText: "Número",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressNeighborhoodController,
            decoration: const InputDecoration(
              labelText: "Bairro",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressCityController,
            decoration: const InputDecoration(
              labelText: "Cidade",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addressStateController,
            decoration: const InputDecoration(
              labelText: "Estado",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: "Telefone",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _documentController,
            decoration: const InputDecoration(
              labelText: "CPF/CNPJ",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          // BOTÃO SALVAR
          ElevatedButton(
            onPressed: () {
              _editProfessional();
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
      ),
    );
  }
}