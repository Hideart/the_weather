class City {
  final String name;
  final String region;
  final String regionCode;

  City({
    required this.name,
    required this.region,
    required this.regionCode,
  });
}

class CitiesResponseMetadata {
  final int currentOffset;
  final int totalCount;

  CitiesResponseMetadata({
    required this.currentOffset,
    required this.totalCount,
  });
}

class CitiesResponse {
  final List<City> data;
  final CitiesResponseMetadata metadata;

  CitiesResponse({required this.data, required this.metadata});
}