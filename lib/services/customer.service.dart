import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camarim_backend/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class CustomerService {
  final String baseUrl = "http://26.40.139.92:3000";

  Future<void> addCustomer(Customer customer) async {
    final url = Uri.parse("$baseUrl/customers");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(customer.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Erro ao cadastrar cliente: ${response.body}");
    }
  }

  Future<void> updateCustomer(String id, Customer data) async {
    final url = Uri.parse("$baseUrl/customers/$id");

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar cliente: ${response.body}");
    }
  }

  Future<Customer> getCustomerById(String id) async {
    final url = Uri.parse("$baseUrl/customers/$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao buscar cliente: ${response.body}");
    }
  }

  Future<List<Customer>> getAllCustomers() async {
    final url = Uri.parse("$baseUrl/customers");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao listar clientes: ${response.body}");
    }
  }

  Future<void> deleteCustomer(String id) async {
    final url = Uri.parse("$baseUrl/customers/$id");

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar cliente: ${response.body}");
    }
  }

  DateTime parseBrazilianDate(String dateString) {
    final parts = dateString.split("/");
    if (parts.length != 3) {
      throw FormatException("Data inválida. Use o formato dd/MM/yyyy");
    }

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }
}
}
