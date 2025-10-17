import 'package:camarim_backend/models/service.dart';

class Professional {
  final int id;
  final String profileImageUrl;
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
    required this.id, 
    required this.profileImageUrl, 
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

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: int.tryParse(json['id'].toString()) ?? 0,
      profileImageUrl: json['profileImageUrl'] ?? '',
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
    );
  }
}