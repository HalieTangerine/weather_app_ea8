import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage ({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{
  //apiKey
  final _weatherService = WeatherService('50dc3021fd580ce30604e4e0c170bd84');
  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch (e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition==null) return 'assets/loading.json';
    //animation weather
    switch (mainCondition.toLowerCase()){
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/fog.json';
      case 'smoke':
        return 'assets/fog.json';
      case 'haze':
        return 'assets/fog.json';
      case 'dust':
        return 'assets/fog.json';
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //if null = loading city.., but if not, shows the city
            Text(_weather?.cityName ?? "loading city..", style: TextStyle(fontSize: 25),),

            //weather app animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),


            //temperature
            Text('${_weather?.temperature.round()}°C', style: TextStyle(fontSize: 30),),

            //weather condition
            Text(_weather?.mainCondition??"", style: TextStyle(fontSize: 20),)
          ],
        )
      ),
    );
  }
}