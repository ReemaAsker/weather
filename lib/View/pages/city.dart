import 'dart:ui';

import 'package:flutter/material.dart';

import '../../Model/cityWeather.dart';

class CityScreen extends StatefulWidget {
  CityWeather cityWeather;
  CityScreen({super.key, required this.cityWeather});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  void onTextfeildClicked(String cityname) async {
    CityWeather cityWeather = CityWeather();
    await cityWeather.getCurrentCityWeather(cityname);
    setState(() {
      widget.cityWeather = cityWeather;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.cityWeather.random_weather_img),
            fit: BoxFit.cover,
          ),
        ),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
              ),
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Image(
                          image: NetworkImage(widget.cityWeather.icon_url,
                              scale: 0.5),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(widget.cityWeather.temperature).round()}°C',
                          style: TextStyle(color: Colors.white, fontSize: 70),
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.cityWeather.cityname,
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          widget.cityWeather.weather_description,
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          onSubmitted: (value) => onTextfeildClicked(value),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                          decoration: InputDecoration(
                              hintText: 'Search another location ...',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Text(
                        widget.cityWeather.error
                            ? ""
                            : widget.cityWeather.error_msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
