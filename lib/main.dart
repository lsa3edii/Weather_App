import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return WeatherProvider();
      },
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  // Weather? weather;

  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // brightness: Brightness.dark,
          primarySwatch: //Colors.orange
              Provider.of<WeatherProvider>(context).weatherData?.getColor() ??
                  Colors.blue
          // Provider.of<WeatherProvider>(context).weatherData == null
          // ? Colors.orange
          // : Provider.of<WeatherProvider>(context).weatherData!.getColor(),
          ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
