class CustomerProfile {
  final String id;
  final String fullName;
  final DateTime birthDate;
  final String username;
  final String email;
  final String phone;
  final String addressStreet;
  final String addressNumber;
  final String addressNeighborhood;
  final String addressCity;
  final String addressState;
  final String addressCep;

  CustomerProfile({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.username,
    required this.email,
    required this.phone,
    required this.addressStreet,
    required this.addressNumber,
    required this.addressNeighborhood,
    required this.addressCity,
    required this.addressState,
    required this.addressCep,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      id: json['id'], 
      fullName: json['fullName'],
      birthDate: DateTime.parse(json['birthDate']),
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      addressStreet: json['addressStreet'],
      addressNumber: json['addressNumber'],
      addressNeighborhood: json['addressNeighborhood'],
      addressCity: json['addressCity'],
      addressState: json['addressState'],
      addressCep: json['addressCep'],
    );
  }
}