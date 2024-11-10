import 'package:ayni_mobile_app/home/models/weather_response.dart';
import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:ayni_mobile_app/shared/utils/temperature_features.dart';
import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  final WeatherResponse weatherDescription;
  const WeatherWidget({
    super.key,
    required this.weatherDescription,
  });

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors["color-light-green"],
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(18, 18, 18, 0.25),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 28,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TemperatureFeatures.toStringFromKelvinToCelcius(
                    widget.weatherDescription.temperature),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: colors["color-text-black"],
                ),
              ),
              Text(
                "Lima, Perú",
                style: TextStyle(
                  fontSize: 14,
                  color: colors["color-text-black"],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 84,
                width: 84,
                child: Image.asset(
                  "assets/images/weather_icons/${widget.weatherDescription.iconId}.png",
                ),
              ),
              Text(
                widget.weatherDescription.description,
                style: TextStyle(
                  fontSize: 14,
                  color: colors["color-text-black"],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
