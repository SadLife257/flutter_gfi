import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gfi/config/themes/themes.dart';
import 'package:gfi/core/utils/dependency_injection.dart';
import 'package:gfi/layers/presentation/pages/AboutUs.dart';
import 'package:gfi/layers/presentation/pages/AuthReDirect.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gfi/layers/presentation/pages/Profile.dart';
import 'package:gfi/layers/presentation/pages/Setting.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceAddPassword.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceManagement.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceScan.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceSetting.dart';
import 'package:gfi/layers/presentation/pages/notification/Notification.dart';
import 'package:gfi/layers/presentation/pages/room/RoomCreate.dart';
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );
  bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
  if(!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return GetMaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        AuthReDirect.route_name: (context) => AuthReDirect(),
        Setting.route_name: (context) => Setting(),
        Profile.route_name: (context) => Profile(),
        AboutUs.route_name: (context) => AboutUs(),
        Notifications.route_name: (context) => Notifications(),
        RoomManagement.route_name: (context) => RoomManagement(),
        RoomCreate.route_name: (context) => RoomCreate(),
        DeviceScan.route_name: (context) => DeviceScan(),
        DeviceManagement.route_name: (context) => DeviceManagement(),
        DeviceAddPassword.route_name: (context) => DeviceAddPassword(),
        DeviceSetting.route_name: (context) => DeviceSetting(),
      },
    );
  }
}