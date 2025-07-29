import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/pages/customers.dart';
import 'package:camarim_backend/models/service.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:camarim_backend/use-cases/add-service.use-case.dart';

class Professionals extends StatefulWidget {
  const Professionals({super.key});

  @override
  State<Professionals> createState() => _ProfessionalsState();
}

class _ProfessionalsState extends State<Professionals> {
  final FirestoreService firestoreService = FirestoreService();
  final ProfessionalService professionalService = ProfessionalService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController serviceDescriptionController = TextEditingController();
  final TextEditingController servicePriceController = TextEditingController();
  final TextEditingController serviceDurationController = TextEditingController();
  final TextEditingController serviceTypeController = TextEditingController();

  void clearTexts() {
    nameController.clear();
    documentController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
  }

  Future<void> showServiceModal({required String professionalId}) async {
    showDialog(context: context, builder: (context) => AlertDialog(      
      content: 
        Column(
          children: [
            Text("Nome do serviço"),
            TextField(controller: serviceNameController,),

            Text("Descrição"),
            TextField(controller: serviceDescriptionController),

            Text("Preço"),
            TextField(controller: servicePriceController),

            Text("Duração"),
            TextField(controller: serviceDurationController),

            Text("Tipo"),
            TextField(controller: serviceTypeController),
          ]
        ),
      actions: [
        ElevatedButton(onPressed: () {
          Type type;

          switch (serviceTypeController.text) {
            case "cabelo":
              type = Type.cabelo;
              break;
            case "manicure":
              type = Type.manicure;
              break;
            case "pedicure":
              type = Type.pedicure;
              break;
            case "maquiagem":
              type = Type.maquiagem;
              break;
            case "estetica":
              type = Type.estetica;
            default:
              throw Exception("Invalid service type");
          }

          final service = Service(
            name: serviceNameController.text,
            description: serviceDescriptionController.text,
            duration: int.parse(serviceDurationController.text),
            professionalId: professionalId,
            price: double.parse(servicePriceController.text),
            type: type.name
          );
          
          addService(professionalId, service);

          clearTexts();
          Navigator.pop(context);
          
        }, child: Text("Adicionar"))
      ],
    ));
  }

  Future<void> showInsertModal({String? id}) async {
    showDialog(context: context, builder: (context) => AlertDialog(      
      content: 
        Column(
          children: [
          Text("Nome do profissional/empresa"),
          TextField(controller: nameController,),

          Text("CPF ou CNPJ"),
          TextField(controller: documentController),

          Text("Email"),
          TextField(controller: emailController),

          Text("Telefone"),
          TextField(controller: phoneController),

          Text("Senha"),
          TextField(controller: passwordController),
          ]
        ),
      actions: [
        ElevatedButton(onPressed: () {
          final professional = Professional
          (
            name: nameController.text,
            document: documentController.text,
            email: emailController.text,
            phone: phoneController.text,
            password: passwordController.text,
          );

          if (id == null ) {
            professionalService.addProfessional(professional);
          } else {
            professionalService.updateProfessional(id, professional);
          }

          clearTexts();
          Navigator.pop(context);
          
        }, child: Text(id == null ? "Adicionar" : "Editar"))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Customers()));
              }, 
              child: Text("Cliente")
            )
          ],
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.get(professionalService.professionals),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List professionalList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: professionalList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot professional = professionalList[index];
                String professionalId = professional.id;
                Map<String, dynamic> data = professional.data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(data.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => showInsertModal(id: professionalId),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.delete(professionalId, professionalService.professionals),
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () => showServiceModal(professionalId: professionalId),
                        icon: const Icon(Icons.work),
                      ),
                    ],
                  ),
                );
              }
            );
          } else {
            return Text("Não há profissionais no banco de dados.");
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showInsertModal,

        child: const Icon(Icons.add)
      ),
    );
  }
}