class ProfessionalProfile {
  final String profileImageUrl;
  final String headerImageUrl;
  final String name;
  final String bio;
  final List<String> socialMediaLinks;
  final List<String> services;
  final List<String> workImages;

  ProfessionalProfile({
    required this.profileImageUrl,
    required this.headerImageUrl,
    required this.name,
    required this.bio,
    required this.socialMediaLinks,
    required this.services,
    required this.workImages,
  });

  factory ProfessionalProfile.fromJson(Map<String, dynamic> json) {
    return ProfessionalProfile(
      profileImageUrl: json['profileImageUrl'] as String,
      headerImageUrl: json['headerImageUrl'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      socialMediaLinks: List<String>.from(json['socialMediaLinks']),
      services: List<String>.from(json['services']),
      workImages: List<String>.from(json['workImages']),
    );
  }
}