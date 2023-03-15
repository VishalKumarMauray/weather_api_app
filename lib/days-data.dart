import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/constant.dart';
import 'package:weather_api/provider/weather_provider.dart';

class daysData extends StatefulWidget {
  daysData({super.key, required this.snapshot});
  var snapshot;

  @override
  State<daysData> createState() => _daysDataState();
}

class _daysDataState extends State<daysData> {
  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<WeatherProvider>(context);
    var dayData = [];

    days(data) {
      var day = DateTime.now().day;
      data!.list!.where((element) {
        if (element.dt_txt!.day == day) {
          dayData.add(element);
          day++;
        }
        return true;
      }).toString();
    }

    days(widget.snapshot);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: darkBlue,
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Back',
                    style: TextStyle(
                      color: white,
                      fontSize: 18,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
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
                          postModel.post?.city?.name ?? '',
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
              const Text(
                'Next 5 days ',
                style: TextStyle(
                  color: white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dayData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: index == 0
                                  ? const Text(
                                      'Today',
                                      style: TextStyle(
                                        color: white,
                                        letterSpacing: 0.5,
                                        fontSize: 22,
                                      ),
                                    )
                                  : index == 1
                                      ? const Text(
                                          'Tomorrow',
                                          style: TextStyle(
                                            color: white,
                                            letterSpacing: 0.5,
                                            fontSize: 22,
                                          ),
                                        )
                                      : Text(
                                          DateFormat('EEEE')
                                              .format(dayData[index].dt_txt),
                                          style: const TextStyle(
                                            color: white,
                                            letterSpacing: 0.5,
                                            fontSize: 22,
                                          ),
                                        ),
                              subtitle: Text(
                                DateFormat('d MMMM')
                                    .format(dayData[index].dt_txt),
                                style: const TextStyle(
                                  color: grey,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Image.network(
                                'https://openweathermap.org/img/wn/${dayData[index].weather!.elementAt(0).icon}@2x.png',
                                scale: 1.7,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
