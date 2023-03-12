import 'package:flutter/material.dart';
import 'package:weather_api/models/weather-forcast.dart';
import 'package:weather_api/services/weather-forcast.service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherData? post;
  bool isLoading = false;

  getData() async {
    isLoading = true;
    post = (await fetchWeather('delhi'))!;
    isLoading = false;
    notifyListeners();
  }
}
