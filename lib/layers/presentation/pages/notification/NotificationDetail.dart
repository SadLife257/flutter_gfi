import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  final String title;
  final String detail;

  NotificationDetail({
    super.key,
    required this.title,
    required this.detail,
  });

  static const route_name = '/notification_detail';

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          title: Icon(Icons.notifications),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 30,
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16
              ),
              child: Text(
                widget.detail,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
