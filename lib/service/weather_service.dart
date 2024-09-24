import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/weather_data_model.dart';

class WeatherService {
  final String apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
  final Dio _dio = Dio();

  Future<Weather?> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        return Weather.fromJson(data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (kDebugMode) {
          print('Server error: ${e.response?.statusCode}');
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        if (kDebugMode) {
          print('Connection timed out');
        }
      } else if (e.type == DioExceptionType.connectionError) {
        if (kDebugMode) {
          print('Network error: ${e.message}');
        }
      }
      return null;
    }
  }
}
