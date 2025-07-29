class Customer {
  final String fullName;
  final String birthDate;
  final String username;
  final String email;
  final String phone;
  final String password;

  Customer({
    required this.fullName,
    required this.birthDate,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> getCustomer() {
    return {
      "fullName": fullName,
      "birthDate": birthDate,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    };
  }
}
