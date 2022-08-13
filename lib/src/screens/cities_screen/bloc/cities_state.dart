class CityState {
  final String name;

  CityState({required this.name});
}

class CitiesState {
  final List<CityState> list;
  final bool loading;
  final bool error;
  final int totalCount;
  final int totalPages;
  final int page;

  CitiesState({
    required this.list,
    this.totalCount = 0,
    this.totalPages = 0,
    this.page = 0,
    this.loading = false,
    this.error = false,
  });
}
