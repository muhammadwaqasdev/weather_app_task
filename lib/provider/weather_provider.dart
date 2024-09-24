import 'package:flutter/material.dart';

import '../model/weather_data_model.dart';
import '../service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _loading = false;
  String? _error;

  Weather? get weather => _weather;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchWeather(String city) async {
    _loading = true;
    notifyListeners();

    final result = await _weatherService.fetchWeather(city);
    if (result != null) {
      _weather = result;
      _error = null;
    } else {
      _error = "Could not fetch weather data. Please try again.";
    }

    _loading = false;
    notifyListeners();
  }
}
