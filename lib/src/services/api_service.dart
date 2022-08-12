import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_weather/src/models/api_model.dart';

final Dio dio = Dio();

class ApiEnvironmentException implements Exception {
  String cause;
  ApiEnvironmentException(this.cause);
}

class API {
  static Future<CitiesResponse> fetchCities({
    int limit = 10,
    int offset = 0,
    String country = 'RU',
    String? search,
  }) async {
    if (dotenv.env['RAPID_API_KEY'] == null) {
      throw ApiEnvironmentException('Env var RAPID_API_KEY is required\nPlease check your .env file');
    }
    final result = await dio.get<CitiesResponse>(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/cities',
      options: Options(
        headers: <String, dynamic>{
          'x-rapidapi-key': dotenv.env['RAPID_API_KEY'],
          'x-rapidapi-host': 'wft-geo-db.p.rapidapi.com',
        },
      ),
      queryParameters: <String, dynamic>{
        'regionIds': country,
        'namePrefix': search,
        'limit': limit,
        'offset': offset,
      },
    );
    return result.data!;
  }
}
