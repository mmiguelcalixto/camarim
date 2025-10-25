import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';
import '../models/customer_update_request.dart';
import '../models/customer_profile.dart';

class CustomerService {
  final String _baseUrl = "http://192.168.15.69:3000";

  Future<bool> registerCustomer(Customer customer) async {
    final url = Uri.parse('$_baseUrl/customers');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},

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

  Future<void> updateCustomer(
    String customerId,
    CustomerUpdateRequest request,
  ) async {
    final url = Uri.parse('$_baseUrl/customers/$customerId');

    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      print('Cliente atualizado com sucesso.');
    } else {
      throw Exception('Falha ao atualizar o cliente: ${response.body}');
    }
  }

  Future<CustomerProfile> getCustomerProfile(String customerId) async {
    final url = Uri.parse('$_baseUrl/customers/$customerId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return CustomerProfile.fromJson(data);
      } else {
        throw Exception('Falha ao carregar o perfil do cliente: ${response.body}');
      }
    } catch (error) {
       throw Exception('Erro de conexão: $error');
    }
  }
}
