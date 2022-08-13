class WeatherState {
  final String? main;
  final TemperatureState? temp;
  final bool loading;
  final bool error;

  WeatherState({this.main, this.temp, this.loading = false, this.error = false});
}

class TemperatureState {
  final int current;
  final int feelsLike;

  TemperatureState({required this.current, required this.feelsLike});
}
