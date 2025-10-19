class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  String get baseUrl => "https://api.myapp.com";

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    print("Acessando API com a única instância do ApiService...");
    return {'id': userId, 'name': 'Utilizador X'};
  }
}