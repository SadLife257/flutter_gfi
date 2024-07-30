import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gfi/layers/data/data_source/LocationService.dart';
import 'package:gfi/layers/data/data_source/WeatherService.dart';
import 'package:gfi/layers/domain/entities/Weather.dart';
import 'package:intl/intl.dart';

class DateWeatherBox extends StatefulWidget {
  const DateWeatherBox({super.key});

  @override
  State<DateWeatherBox> createState() => _DateWeatherBoxState();
}

class _DateWeatherBoxState extends State<DateWeatherBox> {
  late final String date;
  late String time;

  double? longitude;
  double? latitude;
  var openWeatherAPIKeyVar = '11ba7a9b18e11998e24c4a485d736422';
  var result;

  WeatherData weather = WeatherData();

  var temperature;
  var conditionId;
  var cityName;
  var weatherIcon;
  var weatherMessage;
  var location;

  late dynamic weather_info;

  @override
  void initState() {
    DateTime today = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, d MMMM, yyyy');
    date = formatter.format(today);
    time = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

    weather_info = getWeather();
    super.initState();
  }

  Future<dynamic> getWeather() async {
    LocationService myLocation = LocationService();
    await myLocation.getCurrentLocation();
    longitude = await myLocation.getLong();
    latitude = await myLocation.getLat();
    var res = await OpenWeatherAPI(OpenWeatherAPIUrl: 'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$openWeatherAPIKeyVar&units=metric');
    if(res == null){
      print("check API ");
    }
    result = await res.getWeatherData();
    return result;
  }

  void changeUI(dynamic weatherInfo) async {
    // setState(() {
    //   temperature = weatherInfo['main']['temp'].toInt();
    //   conditionId = weatherInfo['weather'][0]['id'];
    //   cityName = weatherInfo['name'];
    //   weatherIcon = weather.getWeatherIcon(conditionId);
    //   weatherMessage = weather.getMessage(temperature);
    // });
    temperature = weatherInfo['main']['temp'].toInt();
    conditionId = weatherInfo['weather'][0]['id'];
    cityName = weatherInfo['name'];
    weatherIcon = weather.getWeatherIcon(conditionId);
    weatherMessage = weather.getMessage(temperature);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      time = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                time,
                style:  TextStyle(fontSize: 35, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                date,
                style:  TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //         'Temperature'
        //     ),
        //     FittedBox(
        //         fit: BoxFit.scaleDown,
        //         child: Icon(
        //           Icons.cloud_outlined,
        //           size: 60,
        //           color: Theme.of(context).colorScheme.primary,
        //         )
        //     ),
        //   ],
        // ),
        FutureBuilder(
          future: weather_info,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData) {
                changeUI(snapshot.data);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                            weatherIcon
                        ),
                        SizedBox(width: 4,),
                        Text(
                            cityName
                        ),
                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${temperature.toString()}°C',
                        style: TextStyle(fontSize: 60, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                );
              }
              if(snapshot.hasError) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        'Temperature'
                    ),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: IconButton(
                          onPressed: () async {
                            await Geolocator.requestPermission().then((permission) {
                              if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
                                setState(() {
                                  weather_info = getWeather();
                                });
                              }
                            });
                          },
                          icon: Icon(
                            Icons.cloud_outlined,
                            size: 60,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                    ),
                  ],
                );
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    'Temperature'
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: IconButton(
                    onPressed: () async {
                      await Geolocator.requestPermission().then((permission) {
                        if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
                          setState(() {
                            weather_info = getWeather();
                          });
                        }
                      });
                    },
                    icon: Icon(
                      Icons.cloud_outlined,
                      size: 60,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
