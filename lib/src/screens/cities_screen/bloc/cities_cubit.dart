import 'package:bloc/bloc.dart';
import 'package:the_weather/packages/repositories/geo_data/geo_data_repository.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/screens/cities_screen/bloc/cities_state.dart';
import 'package:the_weather/src/utils/service_locator.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit([CitiesState? initialState])
      : super(initialState ?? CitiesState(list: []));

  void safetyEmit(CitiesState nextState) {
    if (!this.isClosed) {
      this.emit(nextState);
    }
  }

  Future getCities({
    required int page,
    String? search,
  }) async {
    if (page == 1) {
      this.safetyEmit(
        CitiesState(
          loading: this.state.loading,
          error: this.state.error,
          list: this.state.list,
          totalCount: 0,
          totalPages: 1,
          page: 1,
        ),
      );
    }
    final geodataRepository = DI.get<GeoDataRepository>(
      instanceName: 'geodata',
    );
    this.safetyEmit(
      CitiesState(
        loading: true,
        error: false,
        list: this.state.list,
        totalCount: this.state.totalCount,
        totalPages: this.state.totalPages,
        page: this.state.page,
      ),
    );
    Map<String, dynamic>? geoData;
    try {
      if (this.state.totalCount > 0 && this.state.totalCount < page * 10) {
        return CitiesState(
          loading: false,
          error: false,
          list: this.state.list,
          totalCount: this.state.totalCount,
          totalPages: this.state.totalPages,
          page: this.state.page,
        );
      }
      geoData = await geodataRepository.fetchCities(
        countryCode:
            DI.get<GeoStateCubit>(instanceName: 'geo_state').state.countryCode!,
        limit: 10,
        offset: page == 1 ? 0 : page * 10,
        search: search,
      );
    } catch (e) {
      return this.safetyEmit(
        CitiesState(
          loading: false,
          error: true,
          list: this.state.list,
          totalCount: this.state.totalCount,
          totalPages: this.state.totalPages,
          page: this.state.page,
        ),
      );
    }
    final total = geoData['metadata']['totalCount']! as int;
    return this.safetyEmit(
      CitiesState(
        loading: false,
        error: false,
        list: (geoData['data'] as List<dynamic>)
            .map<CityState>(
              (dynamic cityItem) => CityState(
                name: cityItem['name']! as String,
              ),
            )
            .toList(),
        totalCount: total,
        totalPages: (total / 10).floor() > 0 ? (total / 10).floor() : 1,
        page: page,
      ),
    );
  }
}
