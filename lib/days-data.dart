import 'package:flutter/material.dart';
import 'package:weather_api/constant.dart';

class daysData extends StatefulWidget {
  daysData({super.key, required this.snapshot});
  var snapshot;

  @override
  State<daysData> createState() => _daysDataState();
}

class _daysDataState extends State<daysData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Text(
              widget.snapshot.data!.list!
                  .elementAt(0)
                  .weather!
                  .elementAt(0)
                  .description
                  .toString(),
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
                  widget.snapshot.data!.city!.name.toString(),
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
    );
  }
}
