import 'package:flutter/material.dart';
import 'package:weather_api/models/weather-forcast.dart';
import 'package:weather_api/services/weather-forcast.service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherData? post;
  bool isLoading = false;
  var city = 'delhi';

  getData() async {
    isLoading = true;
    post = (await fetchWeather(city))!;
    isLoading = false;
    notifyListeners();
  }

  updateCity(value) {
    city = value;
    getData();
  }
}
