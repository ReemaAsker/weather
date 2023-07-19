import '../Utilits/cconstant.dart';
import '../services/LoctionWeather.dart';
import '../services/Networking.dart';

class Weather {
  late String name = "";
  late double temperature = 0;
  late int humidity = 0;
  late double wind = 0;
  late String imageURL = "041";
  late String description = "Clear";

  void getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    String URL =
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$APIKey&units=metric";
    Map<String, dynamic> weatherInfo = await NetworkHelper(URL).getData();

    temperature = weatherInfo['main']['temp'];
    name = weatherInfo['name'];
    humidity = weatherInfo['main']['humidity'];
    wind = weatherInfo['wind']['speed'];
    String iconcode = weatherInfo['weather'][0]['icon']; //
    imageURL = 'https://openweathermap.org/img/wn/$iconcode.png';
    description = weatherInfo['weather'][0]['description'];
    //  img =
    //  day;
    // allTime;
  }
}
