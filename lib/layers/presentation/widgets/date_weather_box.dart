import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWeatherBox extends StatefulWidget {
  const DateWeatherBox({super.key});

  @override
  State<DateWeatherBox> createState() => _DateWeatherBoxState();
}

class _DateWeatherBoxState extends State<DateWeatherBox> {
  late final String date;
  late String time;

  @override
  void initState() {
    DateTime today = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, d MMMM, yyyy');
    date = formatter.format(today);
    time = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/cloudy.png',
                  height: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 4,),
                Text(
                    'Cloudy'
                ),
              ],
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '26°C',
                style: TextStyle(fontSize: 60, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        )
      ],
    );
  }
}
