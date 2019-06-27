import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final location_weather;

  LocationScreen(this.location_weather);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherModel = WeatherModel();
  var description;

  var condition;

  var temp;

  var city;

  String icon;

  String msg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update_ui(widget.location_weather);
  }

  update_ui(dynamic weather_date) {
    setState(() {
      if (weather_date == null) {
        temp = 0;
        city = '';
        icon = 'error';
        msg = '';
        return;
      }
      description = weather_date['weather'][0]['description'];
      condition = weather_date['weather'][0]['id'];
      temp = weather_date['main']['temp'].toInt();
      city = weather_date['name'];
      icon = weatherModel.getWeatherIcon(condition);
      msg = weatherModel.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var decoded = await weatherModel.get_loc_wehater();
                      update_ui(decoded);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var new_city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (constext) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (new_city != null) {
                        var decoded =
                            await weatherModel.get_city_wehater(new_city);
                        update_ui(decoded);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$msg in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
