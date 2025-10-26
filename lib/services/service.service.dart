import 'dart:convert';

import 'package:camarim_backend/models/service.dart';
import 'package:http/http.dart' as http;

class ServiceService {
  final String _baseUrl = "http://localhost:3000";

  Future<Service> getById(String serviceId) async {
    final url = Uri.parse('$_baseUrl/services/$serviceId');
    try {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      final response = await http.get(url);
      print(response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print("${Service.fromJson(data)} -----------------------------------------------------");
        return Service.fromJson(data);
      } else {
        throw Exception('Falha ao carregar serviço: ${response.body}');
      }
    } catch (error) {
       throw Exception('Erro de conexão: $error');
    }
  }  
}