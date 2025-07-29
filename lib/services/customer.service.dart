import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camarim_backend/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerService {
  final CollectionReference customers = FirebaseFirestore.instance.collection("customers");

  Future<void> addCustomer(Customer customer) async {
    final createdCustomer = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: customer.email.trim(), 
      password: customer.password.trim(),
    );

    customers.doc(createdCustomer.user!.uid).set(customer.getCustomer());
  }

  Future<void> updateCustomer(String id, Customer data) {
    return customers.doc(id).update({
      "fullName": data.fullName,
      "birthDate": data.birthDate,
      "username": data.username,
      "email": data.email,
      "phone": data.phone,
      "password": data.password,
    });
  }
}