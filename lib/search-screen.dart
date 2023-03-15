import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/provider/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String city = '';
  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<WeatherProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          onChanged: (value) {
            city = value;
          },
        ),
        ElevatedButton(
          onPressed: () {
            postModel.updateCity(city);
          },
          child: const Text('update'),
        ),
      ],
    );
  }
}
