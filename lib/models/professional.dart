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
