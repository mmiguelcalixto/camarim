class ProfessionalProfile {
  final int id; 
  final String name;
  final String email; 
  final String phone;
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
    required this.profileImageUrl,
    required this.headerImageUrl,
    required this.bio,
    required this.socialMediaLinks,
    required this.services,
    required this.workImages,
  });

  factory ProfessionalProfile.fromJson(Map<String, dynamic> json) {
    List<String> parseList(dynamic list) => (list is List) ? List<String>.from(list) : [];

    return ProfessionalProfile(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      headerImageUrl: json['headerImageUrl'] ?? '',
      bio: json['bio'] ?? 'Bio não disponível.',
      socialMediaLinks: parseList(json['socialMediaLinks']),
      services: parseList(json['services']),
      workImages: parseList(json['workImages']),
    );
  }
}