import 'package:flutter/material.dart';

class Weather {
  final String location;
  final String date; // Another Solution DateTime date;
  final double currentTemp;
  final double avgTemp;
  final double maxTemp;
  final double minTemp;
  final String condition;
  List forcastdays;

  Weather(
      {required this.location,
      required this.date,
      required this.currentTemp,
      required this.avgTemp,
      required this.maxTemp,
      required this.minTemp,
      required this.condition,
      required this.forcastdays});

  // null safety problem and assign value
  // Weather.fromJson(dynamic data) {
  //   date = data['location']['localtime'];

  //   var forcast = data['forecast']['forecastday'][0]['day'];
  //   avgTemp = forcast['avgtemp_c'];
  //   maxTemp = forcast['maxtemp_c'];
  //   minTemp = forcast['mintemp_c'];
  //   condition = forcast['condition']['text'];
  // }

  factory Weather.fromJson(dynamic data) {
    var forcast = data['forecast']['forecastday'][0]['day'];

    return Weather(
        location: data['location']['name'],
        date: data['location']
            ['localtime'], // DateTime.parse(data['location']['localtime'])
        currentTemp: data['current']['temp_c'],
        avgTemp: forcast['avgtemp_c'],
        maxTemp: forcast['maxtemp_c'],
        minTemp: forcast['mintemp_c'],
        condition: data['current']['condition']['text'],
        forcastdays: data['forecast']['forecastday']);
  }

  List getForcastDays() {
    List days = [];
    List avgTemps = [];
    List maxTemps = [];
    List minTemps = [];
    List all;

    for (int i = 1; i < forcastdays.length; i++) {
      days.add(forcastdays[i]['date']);
      avgTemps.add(forcastdays[i]['day']['avgtemp_c']);
      maxTemps.add(forcastdays[i]['day']['maxtemp_c']);
      minTemps.add(forcastdays[i]['day']['mintemp_c']);
    }
    all = [days, avgTemps, maxTemps, minTemps];
    // print(days);
    return all;
  }

  String getImage() {
    switch (condition) {
      case 'Clear':
      case 'Light Cloud':
      case 'Sunny':
        return 'assets/images/clear.png';

      case 'Sleet':
      case 'Snow':
      case 'Hail':
      case 'Patchy snow possible':
        return 'assets/images/snow.png';

      case 'Cloudy':
      case 'Partly cloudy':
      case 'Overcast':
      case 'Heavy Cloud':
        return 'assets/images/cloudy.png';

      case 'Patchy rain possible':
      case 'Light Rain':
      case 'Heavy Rain':
      case 'Showers':
        return 'assets/images/rainy.png';

      case 'Thunder':
      case 'Thundersrtorm':
        return 'assets/images/thunderstorm.png';

      default:
        return 'assets/images/116.png';
    }
  }

  MaterialColor getColor() {
    switch (condition) {
      case 'Clear':
      case 'Light Cloud':
      case 'Sunny':
        return Colors.orange;

      case 'Sleet':
      case 'Snow':
      case 'Hail':
      case 'Patchy snow possible':
        return Colors.blue;

      case 'Cloudy':
      case 'Partly cloudy':
      case 'Overcast':
      case 'Heavy Cloud':
        return Colors.blueGrey;

      case 'Patchy rain possible':
      case 'Light Rain':
      case 'Heavy Rain':
      case 'Showers':
        return Colors.blue;

      case 'Thunder':
      case 'Thundersrtorm':
        return Colors.blue;

      default:
        return Colors.blue;
    }
  }

  @override
  String toString() {
    return 'date: $date \navgTemp: $currentTemp \nmaxTemp: $maxTemp \nminTemp: $minTemp \ncondition: $condition';
  }
}
