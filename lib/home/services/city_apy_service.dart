import 'dart:convert';

import 'package:ayni_mobile_app/home/models/city.dart';
import 'package:ayni_mobile_app/home/services/location_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class CityApyService {
  final Uri apiUrl = Uri.parse("${dotenv.get("OPENWEATHER_ENDPOINT")}geo/1.0");
  final String apiKey = dotenv.get("OPENWEATHER_APIKEY");
  final LocationService locationService = LocationService();
  late double latitude;
  late double longitude;

  (double, double) getCurrentPosition() {
    return (latitude, longitude);
  }

  Future<City?> getCurrentCity() async {
    LocationData? position = await locationService.getUserLocation();

    if (position == null) {
      return null;
    }

    latitude = position.latitude!;
    longitude = position.longitude!;

    final response = await http.get(Uri.parse(
        "$apiUrl/reverse?lat=$latitude&lon=$longitude&limit=1&appid=$apiKey"));

    if (response.statusCode != 200) {
      throw Exception("Error ocurred while fetching data.");
    }

    final jsonResponse = jsonDecode(response.body);

    final Map<String, dynamic> cityData = jsonResponse[0];

    City city = City(
      name: cityData["name"],
      countryCode: cityData["country"],
      latitude: latitude,
      longitude: longitude,
    );

    return city;
  }
}
