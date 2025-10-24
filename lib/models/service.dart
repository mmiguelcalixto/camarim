class Service {
  final String? id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final String type;

  Service({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.type,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? '', 
      name: json['name'] ?? 'Serviço sem nome',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      duration: json['duration'] ?? 0,
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "duration": duration,
      "type": type,
    };
  }
}