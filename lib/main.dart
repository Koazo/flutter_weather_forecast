import "package:flutter/material.dart";
import 'package:weather_forecast/models/weahter_forecast_daily.dart';
import 'package:weather_forecast/screens/location_screen.dart';
import 'package:weather_forecast/screens/weather_forecast_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WeatherForecastScreen());
  }
}
