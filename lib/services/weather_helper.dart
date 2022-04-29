import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherHelper {
  Future<Weather> readDataForCity(String userCity) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$userCity&lang=tr&appid=e7642b1625e22989c0d936e142b81776&units=metric");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load.');
    }
  }
}
