import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_api/constant.dart';

class daysData extends StatefulWidget {
  daysData({super.key, required this.snapshot});
  var snapshot;

  @override
  State<daysData> createState() => _daysDataState();
}

class _daysDataState extends State<daysData> {
  var dayData = [];

  days(data) {
    var day = DateTime.now().day + 1;
    data!.list!.where((element) {
      if (element.dt_txt!.day == day) {
        dayData.add(element);
        day++;
      }
      return true;
    }).toString();
  }

  @override
  Widget build(BuildContext context) {
    days(widget.snapshot);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Expanded(
            //   child: Text(
            //     widget.snapshot.list!
            //         .elementAt(0)
            //         .weather!
            //         .elementAt(0)
            //         .description
            //         .toString(),
            //     style: const TextStyle(
            //       color: white,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   width: 64,
            // ),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 1,
            //       color: grey,
            //     ),
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.location_on,
            //         color: white,
            //         size: 20,
            //       ),
            //       const SizedBox(
            //         width: 8,
            //       ),
            //       Text(
            //         widget.snapshot.city!.name.toString(),
            //         style: const TextStyle(
            //           color: white,
            //           fontSize: 18,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
    );
  }
}
