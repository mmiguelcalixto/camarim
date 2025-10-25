enum AppointmentStatus {
  SCHEDULED,
  COMPLETED,
  CANCELED,
}

class Appointment {
  final String? id;
  final String? professionalTimeId;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final String? customerId;
  final String? professionalId;
  final String? serviceId;
  AppointmentStatus? status;

  Appointment({
    this.id,
    this.professionalTimeId,
    this.startsAt,
    this.endsAt,
    this.customerId,
    this.professionalId,
    this.serviceId,
    this.status,
  });

  Map<String, dynamic> getAppointment() {
    return {
      "id": id,
      "professionalTimeId": professionalTimeId,
      "startsAt": startsAt?.toIso8601String(),
      "endsAt": endsAt?.toIso8601String(),
      "customerId": customerId,
      "professionalId": professionalId,
      "serviceId": serviceId,
      "status": status?.name,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      professionalTimeId: json['professionalTimeId'],
      startsAt: json['startsAt'] != null
          ? DateTime.parse(json['startsAt'])
          : null,
      endsAt: json['endsAt'] != null
          ? DateTime.parse(json['endsAt'])
          : null,
      customerId: json['customerId'],
      professionalId: json['professionalId'],
      serviceId: json['serviceId'],
      status: json['status'] != null
          ? AppointmentStatus.values.firstWhere(
              (e) => e.name == json['status'],
              orElse: () => AppointmentStatus.SCHEDULED,
            )
          : null,
    );
  }
}
