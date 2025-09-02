import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camarim_backend/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  final CollectionReference customers = FirebaseFirestore.instance.collection("customers");

  Future<void> addCustomer(Customer customer) async {
    final url = Uri.parse("http://192.168.15.69:3000/customers"); // AVISO PARA O GLEISON: COLOQUE O IP LOCAL DO SEU PC NA URL DA API

    print(customer.getCustomer());
    await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(customer.getCustomer()),
    );
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

  DateTime parseBrazilianDate(String dateString) {
    final parts = dateString.split("/"); // separa dia, mês e ano
    if (parts.length != 3) {
      throw FormatException("Data inválida. Use o formato dd/MM/yyyy");
    }

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }
}