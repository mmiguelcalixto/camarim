import 'dart:convert'; 
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class CustomerService {
  final String _baseUrl = "http://localhost:3000";
  Future<bool> registerCustomer(Customer customer) async {
    final url = Uri.parse('$_baseUrl/customers');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(customer.toJson()),
      );

      if (response.statusCode == 200) {
        print("Sucesso! Cliente cadastrado.");
        print("Resposta da API: ${response.body}");
        return true;
      } else {
        print("Erro ao cadastrar. Status: ${response.statusCode}");
        print("Mensagem de erro: ${response.body}"); 
        return false;
      }
    } catch (error) {
      print("Ocorreu um erro na conexão: $error");
      return false;
    }
  }

}