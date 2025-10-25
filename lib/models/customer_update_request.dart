class CustomerUpdateRequest {
  final String? fullName;
  final String? birthDate; 
  final String? username;
  final String? email;
  final String? phone;
  final String? password;
  final String? addressStreet;
  final String? addressNumber;
  final String? addressNeighborhood;
  final String? addressCity;
  final String? addressState;
  final String? addressCep;

  CustomerUpdateRequest({
    this.fullName,
    this.birthDate,
    this.username,
    this.email,
    this.phone,
    this.password,
    this.addressStreet,
    this.addressNumber,
    this.addressNeighborhood,
    this.addressCity,
    this.addressState,
    this.addressCep,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (fullName != null) data['fullName'] = fullName;
    if (birthDate != null) data['birthDate'] = birthDate;
    if (username != null) data['username'] = username;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (password != null && password!.isNotEmpty) data['password'] = password;
    if (addressStreet != null) data['addressStreet'] = addressStreet;
    if (addressNumber != null) data['addressNumber'] = addressNumber;
    if (addressNeighborhood != null) data['addressNeighborhood'] = addressNeighborhood;
    if (addressCity != null) data['addressCity'] = addressCity;
    if (addressState != null) data['addressState'] = addressState;
    if (addressCep != null) data['addressCep'] = addressCep;
    return data;
  }
}
