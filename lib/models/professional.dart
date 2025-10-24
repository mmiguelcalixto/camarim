import 'package:camarim_backend/models/service.dart';

class Professional {
  final String? id;
  final String name;
  final String document;
  final String email;
  final String phone;
  final String? password;
  final List<Service>? services;
  final String addressStreet;
  final String addressNumber; 
  final String addressNeighborhood;
  final String addressCity; 
  final String addressState; 
  final String addressCep;
  final String? profileImage;
  final double? averageRating;
  final String? description;

  Professional({
    this.id,
    required this.name,
    required this.document,
    required this.email,
    required this.phone,
    this.password,
    required this.addressStreet,
    required this.addressNumber,
    required this.addressNeighborhood,
    required this.addressCity,
    required this.addressState,
    required this.addressCep,
    this.profileImage,
    this.averageRating,
    this.services,
    this.description
  });

  Map<String, dynamic> getProfessional() {
    return {
      "name": name,
      "document": document,
      "email": email,
      "phone": phone,
      "services": services,
      "addressStreet": addressStreet,
      "addressNumber": addressNumber,
      "addressNeighborhood": addressNeighborhood,
      "addressCity": addressCity,
      "addressState": addressState,
      "addressCep": addressCep,
      "profileImage": profileImage,
      "averageRating": averageRating,
      "description": description,
    };
  }

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'],
      name: json['name'],
      document: json['document'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      addressStreet: json['addressStreet'],
      addressNumber: json['addressNumber'],
      addressNeighborhood: json['addressNeighborhood'],
      addressCity: json['addressCity'],
      addressState: json['addressState'],
      addressCep: json['addressCep'],
      profileImage: json['profileImage'],
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      description: json['description'],
      services: (json['services'] as List<dynamic>?)
          ?.map((s) => Service.fromJson(s))
          .toList(),
    );
  }
}