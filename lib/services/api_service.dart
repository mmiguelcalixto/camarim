import 'package:flutter/material.dart';

// PADRÃO SINGLETON: Garante que só exista UMA instância desta classe no app.
class ApiService {
  // 1. Campo estático e privado para armazenar a ÚNICA instância.
  static final ApiService _instance = ApiService._internal();

  // 2. Factory method para fornecer acesso global à instância.
  factory ApiService() {
    return _instance;
  }

  // 3. Construtor privado para impedir a instanciação direta de fora.
  ApiService._internal() {
    // Lógica de inicialização (ex: configurar Dio, HttpClient, etc.)
    debugPrint("ApiService inicializado (Singleton).");
  }

  // Exemplo de uso do serviço
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    // Simula uma chamada de API
    await Future.delayed(const Duration(milliseconds: 500));
    return {'id': userId, 'name': 'Usuário Teste'};
  }
}
