import 'package:ayni_mobile_app/home/models/city.dart';

class Weather {
  final double temperature;
  final String description;
  final String iconId;
  final City city;

  Weather({
    required this.temperature,
    required this.description,
    required this.iconId,
    required this.city,
  });
}
