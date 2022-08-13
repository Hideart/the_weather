import 'package:bloc/bloc.dart';
import 'package:the_weather/packages/repositories/weather/weather_model.dart';
import 'package:the_weather/packages/repositories/weather/weather_repository.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/screens/home_screen/bloc/weather_state.dart';
import 'package:the_weather/src/utils/service_locator.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit([WeatherState? initialState])
      : super(initialState ?? WeatherState(loading: true));

  Future updateWeather() async {
    final weatherRepository = DI.get<WeatherRepository>(
      instanceName: 'weather',
    );
    this.emit(
      WeatherState(
        main: this.state.main,
        temp: this.state.temp,
        loading: true,
        error: false,
      ),
    );
    Weather? weather;
    try {
      weather = await weatherRepository.fetchWeather(
        DI.get<GeoStateCubit>(instanceName: 'geo_state').state.city ?? '',
      );
    } catch (e) {
      return this.emit(
        WeatherState(
          main: this.state.main,
          temp: this.state.temp,
          loading: false,
          error: true,
        ),
      );
    }
    return this.emit(
      WeatherState(
        main: weather.main,
        temp: TemperatureState(
          current: weather.temp?.current ?? 0,
          feelsLike: weather.temp?.feelsLike ?? 0,
        ),
        loading: false,
        error: false,
      ),
    );
  }
}
