class Customer {
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

  Map<String, dynamic> getCustomer() {
    return {
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
}
