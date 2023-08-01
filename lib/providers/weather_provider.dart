import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;
  // String? city;

  WeatherProvider() {}

  set weatherData(WeatherModel? weatherData) {
    _weatherData = weatherData;
    notifyListeners(); // notify ui that something has changed
  }

  WeatherModel? get weatherData => _weatherData; // {
  // return _weatherData;
  // }
}
