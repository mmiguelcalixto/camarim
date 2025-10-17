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
  final String profileImageUrl;

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
    required this.profileImageUrl,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      name: json['name'] ?? '',
      document: json['document'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      addressStreet: json['addressStreet'] ?? '',
      addressNumber: json['addressNumber'] ?? '',
      addressNeighborhood: json['addressNeighborhood'] ?? '',
      addressCity: json['addressCity'] ?? '',
      addressState: json['addressState'] ?? '',
      addressCep: json['addressCep'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }

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
