import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gfi/layers/data/data_source/local/LocationService.dart';
import 'package:gfi/layers/data/data_source/remote/WeatherService.dart';
import 'package:gfi/layers/domain/entities/Weather.dart';
import 'package:intl/intl.dart';

class DateWeatherBox extends StatefulWidget {
  const DateWeatherBox({super.key});

  @override
  State<DateWeatherBox> createState() => _DateWeatherBoxState();
}

class _DateWeatherBoxState extends State<DateWeatherBox> {
  late String date;
  late String time;
  late final Timer timer;

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
  late Stream<dynamic> weather_stream;

  @override
  void initState() {
    time = _formatDateTime(DateTime.now());
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    weather_stream = Stream.fromFuture(getWeather());
    super.initState();
  }

  Future<dynamic> getWeather() async {
    LocationService myLocation = LocationService();
    await myLocation.getCurrentLocation();
    longitude = await myLocation.getLong();
    latitude = await myLocation.getLat();
    var res = await OpenWeatherAPI(OpenWeatherAPIUrl: 'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$openWeatherAPIKeyVar&units=metric');
    if(res == null){
      print("----check API ");
    }
    result = await res.getWeatherData();
    return result;
  }

  Stream<dynamic> fetchWeather() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 100));
      dynamic result = await getWeather();
      print(result);
      yield result;
    }
  }

  void changeUI(dynamic weatherInfo) async {
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
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, d MMMM, yyyy', AppLocalizations.of(context)!.language_code);
    date = formatter.format(today);
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
        StreamBuilder(
          stream: weather_stream,
          builder: (context, snapshot) {
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
            else if(snapshot.hasError) {
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
                              getWeather();
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
                            getWeather();
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
        ),
      ],
    );
  }
}
