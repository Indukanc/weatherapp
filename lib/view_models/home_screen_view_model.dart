import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/views/about_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService apiService = ApiService();

  Weather? weather;
  String? errorMessage;

  final TextEditingController cityController = TextEditingController();

  Future<void> storeWeatherData(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cachedCityName', weather.cityName);
    await prefs.setDouble('cachedTemperature', weather.temperature);
    await prefs.setString('cachedCondition', weather.condition);
  }

  Future<void> loadCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedCityName = prefs.getString('cachedCityName');
    final cachedTemperature = prefs.getDouble('cachedTemperature');
    final cachedCondition = prefs.getString('cachedCondition');

    if (cachedCityName != null &&
        cachedTemperature != null &&
        cachedCondition != null) {
      weather = Weather(
        cityName: cachedCityName,
        temperature: cachedTemperature,
        condition: cachedCondition,
      );
      notifyListeners();
    }
  }

  void clearInput() {
    cityController.clear();
    errorMessage = null;
    weather = null;
    notifyListeners();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cachedCityName');
    await prefs.remove('cachedTemperature');
    await prefs.remove('cachedCondition');

    weather = null;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> getWeather() async {
    final cityName = cityController.text;

    if (cityName.isEmpty) {
      errorMessage = "City name cannot be empty.";
      weather = null;
      notifyListeners();
      return;
    }

    setBusy(true);
    final weatherResponse = await apiService.fetchWeather(cityName);
    setBusy(false);

    if (weatherResponse != null) {
      weather = weatherResponse;
      errorMessage = null;

      // storeWeatherData(weatherResponse);
    } else {
      errorMessage =
          "Unable to fetch data. Please check the city name or your network connection.";
      weather = null;
    }
    notifyListeners();
  }

  void navigateToAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutScreen()),
    );
  }
}
