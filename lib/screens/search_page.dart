import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

// Weather? weatherData; // global varible

class Search extends StatelessWidget {
  String? city;
  // VoidCallback? updateUI;

  // Search({super.key, this.updateUI});

  @override
  Widget build(BuildContext context) {
    // String? city = Provider.of<WeatherProvider>(context, listen: false).city;

    Future<void> setWeather() async {
      WeatherService service = WeatherService();
      WeatherModel? weather = await service.getWeather(city: city!);

      // print(weather.toString());
      // weatherData = weather; // global varible
      // updateUI!();

      Provider.of<WeatherProvider>(context, listen: false).weatherData =
          weather;
      // Provider.of<WeatherProvider>(context, listen: false).city = city;
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Search a City',
        style: TextStyle(fontSize: 25, fontFamily: 'Pacifico'),
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: TextField(
            autofocus: true,
            style: const TextStyle(fontSize: 20),
            onChanged: (data) {
              city = data;
            },
            onSubmitted: (data) async {
              city = data;
              await setWeather();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              border: const OutlineInputBorder(),

              // suffix: GestureDetector(
              //   onTap: () async {
              //     await setWeather();
              //   },
              //   child: const Icon(Icons.search),
              // ),

              suffix: IconButton(
                  onPressed: () async {
                    await setWeather();
                  },
                  icon: const Icon(Icons.search)),
              hintText: 'enter a city',
              label: const Text('Search'),
            ),
          ),
        ),
      ),
    );
  }
}
