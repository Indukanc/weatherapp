import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';

class ApiService {
  final String apiKey = '9d5301cad1cd91f7df967a17a203f78e';

  Future<Weather?> fetchWeather(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        cacheWeatherData(data);

        return Weather.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> cacheWeatherData(Map<String, dynamic> weatherData) async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = jsonEncode(weatherData);
    await prefs.setString('lastWeatherData', weatherJson);
  }
}
