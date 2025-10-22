class ScheduleTimeRequest {
  final String professionalTimeId;
  final String customerId;
  final String serviceId;

  ScheduleTimeRequest({
    required this.professionalTimeId,
    required this.customerId,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'professionalTimeId': professionalTimeId,
      'customerId': customerId,
      'serviceId': serviceId,
    };
  }
}