import 'package:flutter/material.dart';
import 'package:weather/services/weather_services.dart';
import 'package:weather/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('ebd3bdfe74b3d110ba2d9cd8e4c6d260');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case "Clear":
        return "assets/Sun.json";
      case "Clouds":
        return "assets/Clouds.json";
      case "Rain":
        return "assets/Rain.json";
      case "Snow":
        return "assets/Rain.json";
      case "Thunderstorm":
        return "assets/thunder.json";
      case "Drizzle":
        return "assets/Sun.json";
      case "Haze":
        return "assets/Sun.json";

      default:
        return "assets/Rain.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_weather?.cityName ?? "loading..."),
        Lottie.asset(getWeatherIcon(_weather?.mainCondition)),
        Text('${_weather?.temperature.round()}"C"'),
        Text(_weather?.mainCondition ?? "loading...")
      ],
    )));
  }
}
