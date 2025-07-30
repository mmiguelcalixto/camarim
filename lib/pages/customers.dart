import 'package:camarim_backend/models/customer.dart';
import 'package:camarim_backend/pages/login.dart';
import 'package:camarim_backend/pages/professionals.dart';
import 'package:camarim_backend/pages/search.dart';
import 'package:camarim_backend/services/customer.service.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {

  final FirestoreService firestoreService = FirestoreService();
  final CustomerService customerService = CustomerService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void clearTexts() {
    _nameController.clear();
    _birthController.clear();
    _usernameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
  }

  Future<void> showInsertModal({String? id}) async {
    showDialog(context: context, builder: (context) => AlertDialog(      
      content: 
        Column(
          children: [
          Text("Nome completo"),
          TextField(controller: _nameController,),

          Text("Data de nascimento"),
          TextField(controller: _birthController),

          Text("Username"),
          TextField(controller: _usernameController),

          Text("Email"),
          TextField(controller: _emailController),

          Text("Telefone"),
          TextField(controller: _phoneController),

          Text("Senha"),
          TextField(controller: _passwordController),
          ]
        ),
      actions: [
        ElevatedButton(onPressed: () {
          final customer = Customer
          (
            fullName: _nameController.text,
            birthDate: _birthController.text,
            username: _usernameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            password: _passwordController.text,
          );

          if (id == null ) {
            customerService.addCustomer(customer);
          } else {
            customerService.updateCustomer(id, customer);
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Professionals()));
              }, 
              child: Text("Profissionais")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("Login")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
              },
              child: Text("Buscar")
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.get(customerService.customers),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List customerList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: customerList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot customer = customerList[index];
                String customerId = customer.id;
                Map<String, dynamic> data = customer.data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(data.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => showInsertModal(id: customerId),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.delete(customerId, customerService.customers),
                        icon: const Icon(Icons.delete),

                      )
                    ],
                  ),
                );
              }
            );
          } else {
            return Text("Não há clientes no banco de dados.");
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