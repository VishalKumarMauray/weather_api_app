import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/constant.dart';
import 'package:weather_api/days-data.dart';
import 'package:weather_api/models/weather-forcast.dart';
import 'package:weather_api/provider/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';
  var hourData = [];
  var dayData = [];
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

  hourly(data) {
    // var day = DateTime.now().day + 1;
    data!.list!.where((element) {
      print(element['dt_txt'].toString());
      // element['dt_txt'] == DateTime.now().day ? print(element) : null;
      // print(hourData);
      // if (element.dt_txt!.day == day) {
      //   dayData.add(element);
      //   day++;
      // }
      return true;
    }).toString();
  }

  @override
  void initState() {
    dateList();
    super.initState();
    final postModel = Provider.of<WeatherProvider>(context, listen: false);
    postModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<WeatherProvider>(context);
    hourly(postModel.post);
    return postModel.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              body: Container(
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            postModel.post?.list!
                                    .elementAt(0)['weather'][0]['description']
                                    .toString() ??
                                "",
                            style: const TextStyle(
                              color: white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 64,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
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
                                postModel.post?.city['name'].toString() ?? "",
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
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: white,
                            fontSize: 26,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // daysData();
                          },
                          child: const Text(
                            '5 days >',
                            style: TextStyle(
                              color: grey,
                              fontSize: 20,
                            ),
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
                              updateIndex(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                    color: active[index] ? black : lightgrey,
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: darkBlue,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://openweathermap.org/img/wn/${postModel.post?.list!.elementAt(0)['weather'][0]['icon']}@2x.png',
                                scale: 0.6,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 42.0),
                                child: Text(
                                  '${postModel.post?.list!.elementAt(0)['main']['temp'].toInt()}\u00B0',
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: 64,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: lightBlue,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Icon(
                                        Icons.air,
                                        color: Colors.blue[900],
                                      ),
                                      const Text(
                                        'Wind',
                                        style: TextStyle(
                                          color: grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${(postModel.post?.list!.elementAt(0)['wind']['speed'] * 3.6).toInt()} km/h',
                                        style: const TextStyle(
                                          color: lightgrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: lightBlue,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Icon(
                                        Icons.water_drop,
                                        color: Colors.blue[900],
                                      ),
                                      const Text(
                                        'Humidity',
                                        style: TextStyle(
                                          color: grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${postModel.post?.list!.elementAt(0)['main']['humidity']} %',
                                        style: const TextStyle(
                                          color: lightgrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: lightBlue,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Icon(
                                        Icons.visibility,
                                        color: Colors.blue[900],
                                      ),
                                      const Text(
                                        'Visibility',
                                        style: TextStyle(
                                          color: grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${postModel.post?.list!.elementAt(0)['visibility'] ~/ 1000} km',
                                        style: const TextStyle(
                                          color: lightgrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.25,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: hourData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: index == 0 ? darkBlue : null,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('hh:mm a')
                                      .format(hourData[index].dt_txt),
                                  style: const TextStyle(
                                    color: grey,
                                    fontSize: 17,
                                  ),
                                ),
                                Image.network(
                                  'https://openweathermap.org/img/wn/${hourData[index].weather!.elementAt(0).icon}@2x.png',
                                  scale: 1.7,
                                ),
                                Text(
                                  '${hourData[index].main!.temp!.toInt()}\u00B0',
                                  style: const TextStyle(
                                    color: lightgrey,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dayData.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  DateFormat('EEEE, d MMMM')
                                      .format(dayData[index].dt_txt),
                                  style: const TextStyle(
                                    color: white,
                                    letterSpacing: 0.25,
                                  ),
                                ),
                                Image.network(
                                  'https://openweathermap.org/img/wn/${dayData[index].weather!.elementAt(0).icon}@2x.png',
                                  scale: 1.7,
                                ),
                                Text(
                                  '${dayData[index].main!.temp!.toInt()}\u00B0',
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
