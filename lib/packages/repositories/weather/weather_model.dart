import 'package:flutter/material.dart';

enum WeatherIconData {
  clouds('Clouds', Icons.cloud),
  clear('Clear', Icons.sunny),
  thunderstorm('Thunderstorm', Icons.thunderstorm_rounded),
  snow('Snow', Icons.cloudy_snowing),
  rain('Rain', Icons.thunderstorm_rounded),
  drizzle('Drizzle', Icons.cloudy_snowing);

  final IconData icon;
  final String weatherType;
  const WeatherIconData(this.weatherType, this.icon);

  @override
  String toString() => this.weatherType;
}

class Weather {
  final String main;
  final Temperature? temp;

  Weather(this.main, this.temp);
}

class Temperature {
  final int current;
  final int feelsLike;

  Temperature(this.current, this.feelsLike);
}
