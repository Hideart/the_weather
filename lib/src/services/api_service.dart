import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_weather/src/models/api_model.dart';

final Dio dio = Dio();

class ApiEnvironmentException implements Exception {
  String cause;
  ApiEnvironmentException(this.cause);
}

class API {
  static final _rapidApiKey = dotenv.env['RAPID_API_KEY'];

  static Future<GeoResponse<City>> fetchCities({
    int limit = 10,
    int offset = 0,
    String country = 'RU',
    String? search,
  }) async {
    final result = await API._geoGetList<GeoResponse<City>>(
      'cities',
      query: <String, dynamic>{
        'regionIds': country,
        'namePrefix': search,
        'limit': limit,
        'offset': offset,
      },
    );
    return result.data!;
  }

  static Future<GeoResponse<Country>> fetchCountries({
    int limit = 10,
    int offset = 0,
    String? search,
  }) async {
    final result = await API._geoGetList<GeoResponse<Country>>(
      'countries',
      query: <String, dynamic>{
        'namePrefix': search,
        'limit': limit,
        'offset': offset,
      },
    );
    return result.data!;
  }

  static Future<Response<T>> _geoGetList<T>(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) {
    if (_rapidApiKey == null) {
      throw ApiEnvironmentException(
        'Env var RAPID_API_KEY is required\nPlease check your .env file',
      );
    }
    return dio.get<T>(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/$endpoint',
      options: Options(
        headers: <String, dynamic>{
          'x-rapidapi-key': _rapidApiKey,
          'x-rapidapi-host': 'wft-geo-db.p.rapidapi.com',
          ...(headers ?? <String, dynamic>{}),
        },
      ),
      queryParameters: query,
    );
  }
}
