import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/models/current-weather.dart';

Future<WeatherData> fetchWeather(city) async {
  const String key = '03b130fd12f1f53657a2e0773740186e';
  print(city);
  final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$key');
  final response = await http.get(uri);
  try {
    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    throw "$e";
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<WeatherData> futureWeather;
  String city = '';

  @override
  void initState() {
    futureWeather = fetchWeather('delhi');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('weather'),
        ),
        body: FutureBuilder<WeatherData>(
          future: futureWeather,
          builder: (context, snapshot) {
            // DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
            //     snapshot.data!.sys!.sunrise! * 1000);
            // DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
            //     snapshot.data!.sys!.sunset! * 1000);
            // print('${sunrise.hour}:${sunrise.minute} am');
            // print('${sunset.hour - 12}:${sunset.minute} pm');
            print("connection state ${snapshot.connectionState}");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                // if (snapshot.hasError) {
                //   return Text("${snapshot.error}");
                // }
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              ),
                            ),
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'enter the city...',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  city = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (city.isNotEmpty) {
                                setState(() {
                                  futureWeather = fetchWeather(city);
                                });
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: SingleChildScrollView(
                        child:
                            snapshot.connectionState == ConnectionState.done &&
                                    snapshot.hasData
                                ? Column(
                                    children: [
                                      Text(
                                        snapshot.data!.name.toString(),
                                        style: const TextStyle(fontSize: 54),
                                      ),
                                      Image.network(
                                        'https://openweathermap.org/img/wn/${snapshot.data!.weather!.elementAt(0).icon}@2x.png',
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'lat: ${snapshot.data!.coord!.lat.toString()}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'lon: ${snapshot.data!.coord!.lon.toString()}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'id: ${snapshot.data!.weather!.elementAt(0).id}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'main: ${snapshot.data!.weather!.elementAt(0).main}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'description: ${snapshot.data!.weather!.elementAt(0).description}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'icon: ${snapshot.data!.weather!.elementAt(0).icon}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'base: ${snapshot.data!.base}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'feels like: ${snapshot.data!.main!.feels_like}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'humidity: ${snapshot.data!.main!.humidity}', // %
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'pressure: ${snapshot.data!.main!.pressure}', //hpa
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'temp: ${snapshot.data!.main!.temp}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'temp max: ${snapshot.data!.main!.temp_max}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'temp min: ${snapshot.data!.main!.temp_min}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'visibility: ${snapshot.data!.visibility}', // /1000 km
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'speed: ${snapshot.data!.wind!.speed}', // meter/sec
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'deg: ${snapshot.data!.wind!.deg}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'all: ${snapshot.data!.clouds!.all}', //cloudiness %
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'dt: ${snapshot.data!.dt}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'country: ${snapshot.data!.sys!.country}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'id: ${snapshot.data!.sys!.id}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'sun rise: ${snapshot.data!.sys!.sunrise}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'sun set: ${snapshot.data!.sys!.sunset}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        'type: ${snapshot.data!.sys!.type}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'timezone: ${snapshot.data!.timezone}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'id: ${snapshot.data!.id}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'name: ${snapshot.data!.name}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'cod: ${snapshot.data!.cod}',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ],
                                  )
                                : snapshot.hasError
                                    ? Text(snapshot.error.toString())
                                    : const CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
