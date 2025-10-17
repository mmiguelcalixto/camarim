// models/professional_profile.dart

class ProfessionalProfile {
  // CAMPOS DO 'RG' (INFORMAÇÕES BÁSICAS)
  final int id;
  final String name;
  final String email;
  final String phone;
  final String addressCity;

  final String profileImageUrl;
  final String headerImageUrl;
  final String bio;
  final List<String> socialMediaLinks;
  final List<String> services;
  final List<String> workImages;

  ProfessionalProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.addressCity,
    
    // Detalhados
    required this.profileImageUrl,
    required this.headerImageUrl,
    required this.bio,
    required this.socialMediaLinks,
    required this.services,
    required this.workImages,
  });

  factory ProfessionalProfile.fromJson(Map<String, dynamic> json) {
    List<String> parseList(dynamic list) {
      if (list is List) {
        return List<String>.from(list.map((item) => item.toString()));
      }
      return []; 
    }
    
    return ProfessionalProfile(
      // Dados básicos
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? 'Nome não encontrado',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      addressCity: json['addressCity'] ?? '',
      
      profileImageUrl: json['profileImageUrl'] ?? '',
      headerImageUrl: json['headerImageUrl'] ?? '', 
      bio: json['bio'] ?? 'Bio não disponível.', 
      
      socialMediaLinks: parseList(json['socialMediaLinks']),
      services: parseList(json['services']),
      workImages: parseList(json['workImages']),
    );
  }
}