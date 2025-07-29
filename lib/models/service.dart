enum ServiceType { 
  cabelo, 
  manicure, 
  pedicure,
  maquiagem,
  estetica, 
}

class Service {
  final String name;
  final String description;
  final String professionalId;
  final double price;
  final int duration;
  final String type;

  Service({
    required this.name,
    required this.description,
    required this.professionalId,
    required this.price,
    required this.duration,
    required this.type,
  });

  Map<String, dynamic> getService() {
    return {
      "name": name,
      "description": description,
      "professional": professionalId,
      "price": price,
      "duration": duration,
      "type": type,
    };
  }
}
