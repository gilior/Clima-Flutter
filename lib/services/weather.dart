import 'package:clima/utilities/constants.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Future<dynamic> get_loc_wehater() async {
    var loc = Location();
    await loc.getCurrentLocation();
    var url =
        '$api_url?lat=${loc.ltd}&lon=${loc.lng}&appid=$api_key&units=metric';
    do_get_decoded(url);
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> get_city_wehater(new_city) async {
    var url = '$api_city_url?q=$new_city&appid=$api_key&units=metric';
    return await do_get_decoded(url);
  }

  Future do_get_decoded(String url) async {
    var networkService = NetworkService(url);
    var decoded = await networkService.getData();
    return decoded;
  }
}
