import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_api/models/weather-forcast.dart';

Future<WeatherData?> fetchWeather(city) async {
  WeatherData? result;
  const String key = '03b130fd12f1f53657a2e0773740186e';
  final uri = Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$key');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = WeatherData.fromJson(item);
    } else {
      print('error');
    }
  } catch (e) {
    print(e.toString());
    throw e;
  }
  return result;
}
