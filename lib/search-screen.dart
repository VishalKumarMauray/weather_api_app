import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/provider/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.city});
  String city;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onChanged: (value) {
            widget.city = value;
          },
        ),
        ElevatedButton(
          onPressed: () {
            print(widget.city);
          },
          child: const Text('save'),
        ),
      ],
    );
  }
}
