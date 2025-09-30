import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:camarim_backend/models/professional.dart';
import 'package:http/http.dart' as http;

class ProfessionalService {
  final String baseUrl = "http://26.40.139.92:3000";

  Future<void> addProfessional(Professional professional) async {
    final url = Uri.parse("$baseUrl/professionals");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(professional.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Erro ao cadastrar profissional: ${response.body}");
    }
  }

  Future<void> updateProfessional(String id, Professional data) async {
    final url = Uri.parse("$baseUrl/professionals/$id");

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar profissional: ${response.body}");
    }
  }

  Future<Professional> getProfessionalById(String id) async {
    final url = Uri.parse("$baseUrl/professionals/$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Professional.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao buscar profissional: ${response.body}");
    }
  }

  Future<List<Professional>> getAllProfessionals() async {
    final url = Uri.parse("$baseUrl/professionals");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Professional.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao listar profissionais: ${response.body}");
    }
  }

  Future<void> deleteProfessional(String id) async {
    final url = Uri.parse("$baseUrl/professionals/$id");

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar profissional: ${response.body}");
    }
  }
}
