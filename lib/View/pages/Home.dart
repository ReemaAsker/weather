import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/Model/weather.dart';
import 'package:weatherapp/Utilits/cconstant.dart';
import 'package:intl/intl.dart';

import '../../Model/cityWeather.dart';
import 'city.dart';

class HomePgae extends StatefulWidget {
  // List<Weather> weatherData = [];
  final Weather weatherData;
  HomePgae({super.key, required this.weatherData});

  @override
  State<HomePgae> createState() => _HomePageState();
}

class _HomePageState extends State<HomePgae>
    with SingleTickerProviderStateMixin {
  DateTime currentDate = DateTime.now();
  String formattedDate = "";
  String name = "";
  int temp = 0;
  int wind = 0;
  int num = 0;
  String description = "clear";
  String imgURL = 'https://openweathermap.org/img/wn/023.png';

  DateTime time = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late AnimationController _controller;

  @override
  void initState() {
    formattedDate = DateFormat('d MMMM yyyy').format(currentDate);
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Duration of two rotations
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      name = widget.weatherData.name;
      temp = (widget.weatherData.temperature).round();
      wind = (widget.weatherData.wind).round();
      num = widget.weatherData.humidity;
      imgURL = widget.weatherData.imageURL;
      description = widget.weatherData.description;
    });

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://source.unsplash.com/random/sky"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Timer(
                                Duration(microseconds: 30),
                                () {
                                  if (mounted) {
                                    CityWeather cityWe = CityWeather();
                                    cityWe.getCurrentCityWeather('Gaza');
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CityScreen(cityWeather: cityWe);
                                    }));
                                  }
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.location_city,
                                size: 40,
                                color: Colors.white,
                              ),
                            )),
                        SizedBox(),
                      ],
                    ),
                  ]),
              backgroundColor: mainColor.withOpacity(0.3),
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ScaleTransition(
                  scale: _controller,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.4)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              ScaleTransition(
                                  scale: _controller,
                                  child: Image(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(imgURL),
                                    height: 120,
                                    width: 120,
                                  )),
                              Text(
                                description,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),

                          ScaleTransition(
                            scale: _controller,
                            child: Column(
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),

                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Temp',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 20),
                                      ),
                                      ScaleTransition(
                                        scale: _controller,
                                        child: Text(
                                          '$temp°C',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Wind',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 20),
                                      ),
                                      ScaleTransition(
                                        scale: _controller,
                                        child: Text(
                                          '$wind km/h',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Humidity',
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 20),
                                      ),
                                      ScaleTransition(
                                        scale: _controller,
                                        child: Text(
                                          '$num%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Today',
                          //         style: TextStyle(color: Colors.white, fontSize: 28),
                          //       ),
                          //       Text(
                          //         'View Full report',
                          //         style: TextStyle(color: Colors.blue, fontSize: 18),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Expanded(
                          //     child: ListView.builder(
                          //   shrinkWrap: true,
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: 24,
                          //   itemBuilder: (context, index) {
                          //     return Container(
                          //       margin: EdgeInsets.all(15),
                          //       padding: EdgeInsets.all(25),
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           color: Colors.white.withOpacity(0.05)),
                          //       child: Center(
                          //         child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.center,
                          //             children: [
                          //               Image.asset(
                          //                 'assets/icons/sun.png',
                          //                 height: 50,
                          //                 width: 50,
                          //               ),
                          //               SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Column(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //                   Text(
                          //                     '00.00',
                          //                     style: TextStyle(
                          //                         color: Colors.white, fontSize: 18),
                          //                   ),
                          //                   Text(
                          //                     '12 C',
                          //                     style: TextStyle(
                          //                         color: Colors.white, fontSize: 18),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ]),
                          //       ),
                          //     );
                          //   },
                          // )),
                          // SizedBox(
                          //   height: 8,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
