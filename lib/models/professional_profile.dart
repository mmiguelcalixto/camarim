import 'service.dart';

class ProfessionalProfile {
  final String id;
  final String name;
  final String bio;
  final String profileImageUrl;
  final String headerImageUrl;
  final List<Service> services;
  final List<String> workImages;
  final List<String> socialMediaLinks;

  ProfessionalProfile({
    required this.id,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.headerImageUrl,
    required this.services,
    required this.workImages,
    required this.socialMediaLinks,
  });

  factory ProfessionalProfile.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json['services'] as List? ?? [];
    List<Service> serviceList = servicesFromJson.map((s) => Service.fromJson(s)).toList();
    
    var workImagesFromJson = json['portfolio'] as List? ?? [];
    List<String> workImagesList = workImagesFromJson.map((i) => i['imageUrl'] as String).toList();
    
    var socialMediaFromJson = json['socialMedia'] as List? ?? [];
    List<String> socialMediaList = socialMediaFromJson.map((l) => l['link'] as String).toList();

    return ProfessionalProfile(
      id: json['id'],
      name: json['name'] ?? '',
      bio: json['bio'] ?? 'Nenhuma bio disponível.',
      profileImageUrl: json['profileImageUrl'] ?? '',
      headerImageUrl: json['headerImageUrl'] ?? '',
      services: serviceList,
      workImages: workImagesList,
      socialMediaLinks: socialMediaList,
    );
  }

  String get body => bio;
}
