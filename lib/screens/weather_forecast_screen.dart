import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_forecast/Widgets/city_view.dart';
import 'package:weather_forecast/api/weather_api.dart';
import 'package:weather_forecast/models/weahter_forecast_daily.dart';
import 'package:weather_forecast/screens/city_screen.dart';
import 'package:weather_forecast/widgets/button_list_view.dart';
import 'package:weather_forecast/widgets/detail_view.dart';
import 'package:weather_forecast/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  const WeatherForecastScreen({this.locationWeather});

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast?> forecastObject;
  String _cityName = 'Нью-Йорк';

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = WeatherApi().fetchWeatherForecast();
    }

    // forecastObject.then((weather) {
    //   print(weather?.list?[0].weather?[0].main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('openweathermap.org'),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              setState(() {
                forecastObject = WeatherApi().fetchWeatherForecast();
              });
            }),
        actions: [
          IconButton(
            onPressed: () async {
              var tappedName = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return CityScreen();
              }));
              if (tappedName != null) {
                setState(() {
                  _cityName = tappedName;
                  forecastObject = WeatherApi()
                      .fetchWeatherForecast(cityName: _cityName, isCity: true);
                });
              }
            },
            icon: const Icon(Icons.location_city),
          )
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder<WeatherForecast?>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      CityView(snapshot: snapshot),
                      const SizedBox(height: 50),
                      TempView(snapshot: snapshot),
                      const SizedBox(height: 50),
                      DetailView(snapshot: snapshot),
                      const SizedBox(height: 50),
                      ButtonListView(snapshot: snapshot),
                    ],
                  );
                } else {
                  return const Center(
                    child: SpinKitDoubleBounce(
                      color: Colors.black87,
                      size: 100,
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
