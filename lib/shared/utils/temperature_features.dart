class TemperatureFeatures {
  static int kelvinToCelcius(double temperatureInKelvin) {
    return (temperatureInKelvin - 273.15).round();
  }

  static String toStringFromKelvinToCelcius(double temperatureInKelvin) {
    return "${kelvinToCelcius(temperatureInKelvin)} °C";
  }
}
