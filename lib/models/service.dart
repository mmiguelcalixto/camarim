enum Type { 
  cabelo, 
  manicure, 
  pedicure,
  maquiagem,
  estetica, 
}

class Service {
  final String? id;
  final String name;
  final String description;
  final String professionalId;
  final double price;
  final int duration;
  final String type;

  Service({
    this.id,
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

factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      duration: json['duration'],
      price: (json['price'] as num).toDouble(),
      type: json['type'],
      professionalId: json['professionalId'],
    );
  }
}
