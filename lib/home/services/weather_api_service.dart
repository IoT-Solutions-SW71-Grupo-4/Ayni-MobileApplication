import 'dart:convert';

import 'package:ayni_mobile_app/home/models/weather_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  final Uri apiUrl =
      Uri.parse("${dotenv.get("OPENWEATHER_ENDPOINT")}data/2.5/forecast");
  final String apiKey = dotenv.get("OPENWEATHER_APIKEY");
  final double latitude = 62.38026;
  final double longitude = 132.28074;

  Future<WeatherResponse> getWeather() async {
    final response = await http
        .get(Uri.parse("$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final Map<String, dynamic> weatherData = jsonResponse["list"][0];

      WeatherResponse weatherResponse = WeatherResponse(
        temperature: weatherData["main"]["temp"],
        description: weatherData["weather"][0]["main"],
        iconId: weatherData["weather"][0]["icon"],
      );

      return weatherResponse;
    } else {
      throw Exception("Failed loading weather data.");
    }
  }
}
