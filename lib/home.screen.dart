import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<WeatherData> fetchWeather(city) async {
  const String key = '03b130fd12f1f53657a2e0773740186e';
  print(city);
  final response = await http.get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$key'),
  );
  if (response.statusCode == 200) {
    print("response.statusCode ${response.statusCode}");
    return WeatherData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

class WeatherData {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherData({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  WeatherData.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({
    this.lat,
    this.lon,
  });

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Main {
  double? temp;
  double? feels_like;
  double? temp_min;
  double? temp_max;
  int? pressure;
  int? humidity;

  Main({
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    this.pressure,
    this.humidity,
  });
  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feels_like = json['feels_like'];
    temp_min = json['temp_min'];
    temp_max = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}

class Wind {
  double? speed;
  int? deg;
  Wind({
    this.speed,
    this.deg,
  });
  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
  }
}

class Clouds {
  int? all;
  Clouds({
    this.all,
  });
  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
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
            // switch (snapshot.connectionState) {
            // case ConnectionState.none:
            // return const Center(child: CircularProgressIndicator());
            // case ConnectionState.waiting:
            // return const Center(child: CircularProgressIndicator());
            // case ConnectionState.active:
            // return const Center(child: CircularProgressIndicator());
            // case ConnectionState.done:
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
                    child: snapshot.connectionState == ConnectionState.done &&
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
                                'humidity: ${snapshot.data!.main!.humidity}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                'pressure: ${snapshot.data!.main!.pressure}',
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
                                'visibility: ${snapshot.data!.visibility}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'speed: ${snapshot.data!.wind!.speed}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(
                                'deg: ${snapshot.data!.wind!.deg}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                'all: ${snapshot.data!.clouds!.all}',
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
                            ? const Text("Please check the entered city!")
                            : const CircularProgressIndicator(),
                  ),
                ),
              ],
            );
            // }
          },
        ),
      ),
    );
  }
}
