class SearchFilter {
  final String? neighborhood;
  final String? serviceType;
  final double? priceMax;
  final double? priceMin;

  SearchFilter({
    this.neighborhood,
    this.serviceType,
    this.priceMax,
    this.priceMin,
  });

  Map<String, String> toQueryParameters() {
    final Map<String, String> params = {};

    if (neighborhood != null && neighborhood!.isNotEmpty) {
      params['neighborhood'] = neighborhood!;
    }
    if (serviceType != null && serviceType!.isNotEmpty) {
      params['serviceType'] = serviceType!;
    }
    if (priceMax != null) {
      params['priceMax'] = priceMax!.toString();
    }
    if (priceMin != null) {
      params['priceMin'] = priceMin!.toString();
    }
    return params;
  }
}
