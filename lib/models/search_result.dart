class SearchResult {
  final int id;
  final String name;
  final String profileImageUrl;
  final String addressCity;
  final double rating; 

  SearchResult({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.addressCity,
    required this.rating,

  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? 'Nome não encontrado',
      profileImageUrl: json['profileImageUrl'] ?? '',
      addressCity: json['addressCity'] ?? 'Cidade não informada',
      rating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}