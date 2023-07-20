import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp/Model/cityWeather.dart';
import 'package:weatherapp/Model/weather.dart';
import 'package:weatherapp/View/pages/Home.dart';
import 'package:weatherapp/View/pages/city.dart';
import 'package:weatherapp/services/LoctionWeather.dart';
import 'package:weatherapp/services/Networking.dart';
import '../../Utilits/cconstant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getWeatherData() async {
    Weather weatherInfo = await Weather()
      ..getCurrentLocationWeather();

    Timer(
      Duration(seconds: 6),
      () {
        if (mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePgae(weatherData: weatherInfo);
          }));
        }
      },
    );
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 245, 252).withOpacity(0.7),
        body: Container(
          child: Center(
            child: Image(image: AssetImage('assets/weather_loading.gif')),
          ),
        ),
      ),
    );
  }
}
