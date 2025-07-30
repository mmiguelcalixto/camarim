import 'package:camarim_backend/models/service.dart';

class Professional {
  final String name;
  final String document;
  final String email;
  final String phone;
  final String password;
  final List<Service>? services;

  Professional({
    required this.name,
    required this.document,
    required this.email,
    required this.phone,
    this.services,
    required this.password,
  });

  Map<String, dynamic> getProfessional() {
    return {
      "name": name,
      "document": document,
      "email": email,
      "phone": phone,
      "services": services,
      "password": password,
    };
  }
}
