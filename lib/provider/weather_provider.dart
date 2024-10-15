import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_application/models/weather_model.dart';
import 'package:weather_application/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String _errorMessage = '';

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchWeatherData(String city) async {
    _isLoading = true;
    _errorMessage = '';
    _weather = null;
    notifyListeners();

    try {
      _weather = await WeatherService().fetchWeather(city);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'City not found';
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveCityToLocalStorage(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', city);
  }

  Future<void> loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCity = prefs.getString('lastCity');

    if (lastCity != null && lastCity.isNotEmpty) {
      await fetchWeatherData(lastCity);
    }
  }
}
