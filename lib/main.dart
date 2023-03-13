import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/main-screen.dart';
import 'package:weather_api/provider/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MaterialApp(
        title: 'Weather',
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
