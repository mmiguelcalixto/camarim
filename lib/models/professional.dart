import 'package:camarim_backend/models/service.dart';

class Professional {
  final String name;
  final String document;
  final String email;
  final String phone;
  final String password;
  final List<Service>? services;
  final String addressStreet;
  final String addressNumber; 
  final String addressNeighborhood;
  final String addressCity; 
  final String addressState; 
  final String addressCep;

  Professional({
    required this.name,
    required this.document,
    required this.email,
    required this.phone,
    required this.addressStreet,
    required this.addressNumber,
    required this.addressNeighborhood,
    required this.addressCity,
    required this.addressState,
    required this.addressCep,
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
      "addressStreet": addressStreet,
      "addressNumber": addressNumber,
      "addressNeighborhood": addressNeighborhood,
      "addressCity": addressCity,
      "addressState": addressState,
      "addressCep": addressCep,
    };
  }
}
