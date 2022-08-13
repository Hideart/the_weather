class CountryState {
  final String name;
  final String code;

  CountryState({required this.name, required this.code});
}

class CountriesState {
  final List<CountryState> list;
  final bool loading;
  final bool error;
  final int totalCount;
  final int totalPages;
  final int page;

  CountriesState({
    required this.list,
    this.totalCount = 0,
    this.totalPages = 0,
    this.page = 0,
    this.loading = false,
    this.error = false,
  });
}
