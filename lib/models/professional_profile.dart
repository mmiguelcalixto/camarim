import 'service.dart';

List<String> parseList(dynamic json) {
  if (json == null) return [];
  if (json is List) {
    return json
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
  }
  if (json is String) {
    return json
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
  return [];
}

class ProfessionalProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String headerImageUrl;
  final String bio;
  final List<String> socialMediaLinks;
  final List<Service> services;
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
    var serviceListFromJson = json['services'] as List<dynamic>? ?? [];
    List<Service> serviceList =
        serviceListFromJson
            .map((serviceJson) => Service.fromJson(serviceJson))
            .toList();

    return ProfessionalProfile(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      headerImageUrl: json['headerImageUrl'] ?? '',
      bio: json['bio'] ?? 'Bio não disponível.',
      socialMediaLinks: parseList(json['socialMediaLinks']),
      services: serviceList,
      workImages: parseList(json['workImages']),
    );
  }
}
