import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final String _baseUrl = 'http://api.weatherapi.com/v1';
  final String _apiKey = '375a055603ea445a969142025232707';

  WeatherService();

  Future<WeatherModel?> getWeather({required String city}) async {
    try {
      Uri url =
          Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$city&days=6');
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);

      WeatherModel weather = WeatherModel.fromJson(data);
      return weather;
    } on Exception catch (ex) {
      print(ex);
    }
    return null;
  }

  // Future<http.Response> response() async {
  //   Uri url = Uri.parse(
  //       'http://api.weatherapi.com/v1/current.json?key=375a055603ea445a969142025232707&q=London&aqi=no');
  //   http.Response res = await http.get(url);
  //   return res;
  // }

  // Future<Weather> getWeather({required String city}) async {
  //   Uri url = Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$city&days=1');
  //   http.Response response = await http.get(url);
  //   Map<String, dynamic> data = jsonDecode(response.body);

  //   var forcast = data['forecast']['forecastday'][0]['day'];
  //   Weather weather = Weather(
  //       date: data['location']['localtime'],
  //       avgTemp: forcast['avgtemp_c'],
  //       maxTemp: forcast['maxtemp_c'],
  //       minTemp: forcast['mintemp_c'],
  //       condition: forcast['condition']['text']);

  //   return weather;
  // }
}
