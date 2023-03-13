import 'package:flutter/material.dart';
import 'package:weather_api/models/weather-forcast.dart';
import 'package:weather_api/services/weather-forcast.service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherData? post;
  bool isLoading = false;

  getData(city) async {
    isLoading = true;
    post = (await fetchWeather(city))!;
    isLoading = false;
    notifyListeners();
  }
}
