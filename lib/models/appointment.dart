class Appointment {
  final String id;
  final String professionalId;
   String professionalName;
  final String serviceName;
  final DateTime startTime;
  final DateTime endTime;
  final String status; 

  Appointment({
    required this.id,
    required this.professionalId,
    required this.professionalName,
    required this.serviceName,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    final professional = json['professional'] as Map<String, dynamic>?;
    final service = json['service'] as Map<String, dynamic>?;

    return Appointment(
      id: json['id'],
      professionalId: json['professionalId'],
      professionalName: professional?['name'] ?? 'Profissional não encontrado',
      serviceName: service?['name'] ?? 'Serviço não encontrado',
      startTime: DateTime.parse(json['startsAt']),
      endTime: DateTime.parse(json['endsAt']),
      status: json['status'],
    );
  }
}

