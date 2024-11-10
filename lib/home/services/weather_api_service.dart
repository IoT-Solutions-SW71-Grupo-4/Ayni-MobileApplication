import 'dart:convert';

import 'package:ayni_mobile_app/home/models/city.dart';
import 'package:ayni_mobile_app/home/models/weather.dart';
import 'package:ayni_mobile_app/home/services/city_apy_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  final Uri apiUrl =
      Uri.parse("${dotenv.get("OPENWEATHER_ENDPOINT")}data/2.5/forecast");
  final String apiKey = dotenv.get("OPENWEATHER_APIKEY");
  final CityApyService cityApyService = CityApyService();
  final Weather weatherForErrors = Weather(
    temperature: 293.15,
    description: "cloud",
    iconId: "01d",
    city: City(
      name: "Lima",
      countryCode: "PE",
      latitude: -12.04,
      longitude: -77.04,
    ),
  );

  Future<Weather?> getWeather() async {
    City? city = await cityApyService.getCurrentCity();

    if (city == null) return weatherForErrors;

    var (latitude, longitude) = cityApyService.getCurrentPosition();

    final response = await http
        .get(Uri.parse("$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final Map<String, dynamic> weatherData = jsonResponse["list"][0];

      Weather weatherResponse = Weather(
        temperature: weatherData["main"]["temp"],
        description: weatherData["weather"][0]["main"],
        iconId: weatherData["weather"][0]["icon"],
        city: city,
      );

      return weatherResponse;
    } else {
      throw Exception("Failed loading weather data.");
    }
  }
}
