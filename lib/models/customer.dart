import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String? id; 
  final String fullName;
  final DateTime birthDate;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String addressStreet;
  final String addressNumber;
  final String addressNeighborhood;
  final String addressCity;
  final String addressState;
  final String addressCep;

  Customer({
    this.id,
    required this.fullName,
    required this.birthDate,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.addressStreet,
    required this.addressNumber,
    required this.addressNeighborhood,
    required this.addressCity,
    required this.addressState,
    required this.addressCep,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "fullName": fullName,
      "birthDate": birthDate.toIso8601String(), 
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "addressStreet": addressStreet,
      "addressNumber": addressNumber,
      "addressNeighborhood": addressNeighborhood,
      "addressCity": addressCity,
      "addressState": addressState,
      "addressCep": addressCep,
    };
  }


  factory Customer.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) {
        return value.toDate(); 
      } else if (value is String) {
        return DateTime.parse(value); 
      } else {
        throw Exception("Formato de data inválido: $value");
      }
    }

    return Customer(
      id: json["id"] ?? json["_id"], 
      fullName: json["fullName"] ?? "",
      birthDate: parseDate(json["birthDate"]),
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      password: json["password"] ?? "",
      addressStreet: json["addressStreet"] ?? "",
      addressNumber: json["addressNumber"] ?? "",
      addressNeighborhood: json["addressNeighborhood"] ?? "",
      addressCity: json["addressCity"] ?? "",
      addressState: json["addressState"] ?? "",
      addressCep: json["addressCep"] ?? "",
    );
  }

  factory Customer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Customer.fromJson({
      "id": doc.id,
      ...data,
    });
  }
}
