import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/professional.dart';
import '../models/professional_profile.dart';
import '../models/search_result.dart';
import '../models/search_filter.dart';

class ProfessionalService {
  final String baseUrl = "http://localhost:3000/professionals";

  // ==========================
  // CREATE PROFESSIONAL
  // ==========================
  Future<Response?> createProfessional(Professional professional, File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

      request.fields['name'] = professional.name;
      request.fields['document'] = professional.document;
      request.fields['email'] = professional.email;
      request.fields['phone'] = professional.phone;
      request.fields['password'] = professional.password!;
      request.fields['addressStreet'] = professional.addressStreet;
      request.fields['addressNumber'] = professional.addressNumber;
      request.fields['addressNeighborhood'] = professional.addressNeighborhood;
      request.fields['addressCity'] = professional.addressCity;
      request.fields['addressState'] = professional.addressState;
      request.fields['addressCep'] = professional.addressCep;

      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage',
          imageFile.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 409 && response.body == "Email already exists") {
        Fluttertoast.showToast(
          msg: "Esse email já está cadastrado por outro usuário.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (response.statusCode == 409 && response.body == "Document already exists") {
        Fluttertoast.showToast(
          msg: "Esse documento já está cadastrado por outro usuário.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      return response;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocorreu um erro ao criar o profissional.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  // ==========================
  // GET PROFESSIONAL BY ID
  // ==========================
  Future<ProfessionalProfile?> getProfessionalById(String id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$id"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProfessionalProfile.fromJson(data);
      } else {
        throw Exception('Falha ao carregar dados do profissional');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erro ao buscar profissional.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  // ==========================
  // UPDATE PROFESSIONAL
  // ==========================
  Future<Response?> updateProfessional(String id, Professional data, File? imageFile) async {
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse("$baseUrl/$id"));

      request.fields['name'] = data.name;
      request.fields['document'] = data.document;
      request.fields['email'] = data.email;
      request.fields['phone'] = data.phone;
      request.fields['addressStreet'] = data.addressStreet;
      request.fields['addressNumber'] = data.addressNumber;
      request.fields['addressNeighborhood'] = data.addressNeighborhood;
      request.fields['addressCity'] = data.addressCity;
      request.fields['addressState'] = data.addressState;
      request.fields['addressCep'] = data.addressCep;
      request.fields['description'] = data.description ?? "";

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profileImage',
            imageFile.path,
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 409 && response.body == "Email already exists") {
        Fluttertoast.showToast(
          msg: "Esse email já está cadastrado por outro usuário.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (response.statusCode == 409 && response.body == "Document already exists") {
        Fluttertoast.showToast(
          msg: "Esse documento já está cadastrado por outro usuário.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Perfil atualizado com sucesso!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      return response;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocorreu um erro ao atualizar o profissional.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  // ==========================
  // GET ALL PROFESSIONALS
  // ==========================
  Future<List<Professional>> getProfessionals() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Professional.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar profissionais');
    }
  }

  // ==========================
  // SEARCH PROFESSIONALS
  // ==========================
  Future<List<SearchResult>> searchProfessionals({String? query, SearchFilter? filter}) async {
    final filterParams = filter?.toQueryParameters() ?? {};

    if (query != null && query.isNotEmpty) {
      filterParams['q'] = query;
    }

    final url = Uri.parse('$baseUrl/search').replace(queryParameters: filterParams);
    print('URL DE BUSCA SENDO CHAMADA: $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => SearchResult.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar profissionais: ${response.body}');
    }
  }
}
