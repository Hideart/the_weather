import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:the_weather/src/app_state/geo/geo_state.dart';

class GeoStateCubit extends HydratedCubit<GeoState> with ChangeNotifier {
  GeoStateCubit([GeoState? initialState]) : super(initialState ?? GeoState());

  void setCountry(String countryCode) =>
      this.emit(GeoState(countryCode: countryCode));

  void setCity(String cityName) {
    this.emit(GeoState(countryCode: this.state.countryCode, city: cityName));
    this.notifyListeners();
  }

  @override
  GeoState? fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? geoState =
        json['geo_state'] as Map<String, dynamic>?;
    if (geoState != null) {
      return GeoState(
        countryCode: geoState['countryCode'] as String?,
        city: geoState['city'] as String?,
      );
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson(GeoState state) {
    return <String, dynamic>{
      'geo_state': {
        'city': state.city,
        'countryCode': state.countryCode,
      }
    };
  }
}
