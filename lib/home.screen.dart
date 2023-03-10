import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_api/constant.dart';
import 'package:weather_api/models/weather-forcast.dart';

Future<WeatherData> fetchWeather(city) async {
  const String key = '03b130fd12f1f53657a2e0773740186e';
  final uri = Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$key');

  final response = await http.get(uri);
  try {
    if (response.statusCode == 200) {
      // print(response.body);
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
  List<String> dates = [];
  List<int> datesDays = [];
  List<bool> active = [
    true,
    false,
    false,
    false,
    false,
  ];

  dateList() {
    final currentDate = DateTime.now();
    for (int i = 0; i < 5; i++) {
      final date = DateFormat('EEEE, d MMMM').format(
        currentDate.add(
          Duration(days: i),
        ),
      );
      dates.add(date.toString());
      datesDays.add(
        int.parse(
          DateFormat('d').format(
            currentDate.add(
              Duration(days: i),
            ),
          ),
        ),
      );
    }
  }

  updateIndex(index) {
    for (int i = 0; i < 5; i++) {
      if (i == index) {
        setState(() {
          active[i] = true;
        });
      } else {
        setState(() {
          active[i] = false;
        });
      }
    }
  }

  Weather() {
    print(datesDays);
  }

  @override
  void initState() {
    futureWeather = fetchWeather('delhi');
    dateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<WeatherData>(
          future: futureWeather,
          builder: (context, snapshot) {
            // DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
            //     snapshot.data!.sys!.sunrise! * 1000);
            // DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
            //     snapshot.data!.sys!.sunset! * 1000);
            // print('${sunrise.hour}:${sunrise.minute} am');
            // print('${sunset.hour - 12}:${sunset.minute} pm');
            // city = snapshot.data!.city!.name.toString();

            return (snapshot.data != null)
                ? Container(
                    color: Colors.black,
                    padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'text according to the climate!',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 64,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: grey,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: white,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    snapshot.data!.city!.name.toString(),
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Today',
                              style: TextStyle(
                                color: white,
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              '5 days >',
                              style: TextStyle(
                                color: grey,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dates.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // updateIndex(index);
                                  Weather();
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: active[index] ? pink : null,
                                    border: Border.all(
                                      width: 2,
                                      color: active[index] ? pink : darkBlue,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      dates[index],
                                      style: TextStyle(
                                        color:
                                            active[index] ? black : lightgrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: darkBlue,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Text(snapshot.data.list);
                                  // Image.network(
                                  // 'https://openweathermap.org/img/wn/${snapshot.data!.weather!.elementAt(0).icon}@2x.png',
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : snapshot.hasError
                    ? Text(snapshot.error.toString())
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
          },
        ),
      ),
    );
  }
}
