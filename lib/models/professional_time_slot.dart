class ProfessionalTimeSlot {
  final String id;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isAvailable;

  ProfessionalTimeSlot({
    required this.id,
    required this.startsAt,
    required this.endsAt,
    required this.isAvailable,
  });

  factory ProfessionalTimeSlot.fromJson(Map<String, dynamic> json) {
    return ProfessionalTimeSlot(
      id: json['id'],
      startsAt: DateTime.parse(json['startsAt']),
      endsAt: DateTime.parse(json['endsAt']),
      isAvailable: json['isAvailable'] ?? json['isAvaliable'] ?? false,
    );
  }
}

