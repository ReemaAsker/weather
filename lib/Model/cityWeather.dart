import '../services/Networking.dart';

class CityWeather {
  String URL = "";
  String icon_url = "http://openweathermap.org/img/w/01n.png";
  String random_weather_img = "https://source.unsplash.com/random/?weather";
  String icon_weather = 'cold';
  String error_msg = "";
  bool error = false;
  String cityname = "";
  double temperature = 0;
  String weather_description = "clear";
  Future<void> getCurrentCityWeather(String cityName) async {
    try {
      URL =
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=10edd29a4b3f02d6048a18589d3fc036&units=metric";
      Map<String, dynamic> cityWeather = await NetworkHelper(URL).getData();
      cityname = cityWeather['name'];
      temperature = (cityWeather['main']['temp']);
      temperature = temperature;
      weather_description = cityWeather['weather'][0]['description'];
      random_weather_img = random_weather_img + weather_description;
      icon_weather = cityWeather['weather'][0]['icon'];
      icon_url = "http://openweathermap.org/img/w/" + icon_weather + ".png";
      error = false;
    } catch (e) {
      error = true;
      error_msg = "Sorry , we don't have data about this city,try again";
      icon_url = "http://openweathermap.org/img/w/01n.png";
    }
  }
}
