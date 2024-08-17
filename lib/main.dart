import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gfi/core/translation/localization.dart';
import 'package:gfi/core/utils/dependency_injection.dart';
import 'package:gfi/layers/data/data_source/local/BackgroundService.dart';
import 'package:gfi/layers/data/data_source/local/Notification.dart';
import 'package:gfi/layers/data/data_source/remote/firebase/firestore/room.dart';
import 'package:gfi/layers/domain/entities/Relation/Hardware_2_Room.dart';
import 'package:gfi/layers/domain/entities/Notifier/Locale.dart';
import 'package:gfi/layers/domain/entities/Room/Room.dart';
import 'package:gfi/layers/domain/entities/Notifier/Theme.dart';
import 'package:gfi/layers/presentation/pages/AboutUs.dart';
import 'package:gfi/layers/presentation/pages/AuthReDirect.dart';
import 'package:gfi/layers/presentation/pages/OnBoarding.dart';
import 'package:gfi/layers/presentation/pages/Profile.dart';
import 'package:gfi/layers/presentation/pages/Setting.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceScan.dart';
import 'package:gfi/layers/presentation/pages/device/DeviceSetting.dart';
import 'package:gfi/layers/presentation/pages/notification/Notification.dart';
import 'package:gfi/layers/presentation/pages/room/RoomCreate.dart';
import 'package:gfi/layers/presentation/pages/room/RoomManagement.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

int? initScreen;

void main() async{
  DependencyInjection.init();

  bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
  if(!isNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) async {
    await initializeService();
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();

  initScreen = await prefs.getInt("onboard");

  // await Future.delayed(Duration(milliseconds: 500), () {
  //   runApp(MyApp());
  // });

  runApp(MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

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
            ledColor: Colors.white,
            importance: NotificationImportance.High,
        ),
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: true,
      autoStartOnBoot: true,
    ),
  );

  //service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // service.on("stop").listen((event) {
  //   service.stopSelf();
  //   print("background process is now stopped");
  // });

  service.on("start").listen((event) {
    print("service is successfully running ${DateTime.now().second}");
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    FirestoreRoomCRUD ref = await FirestoreRoomCRUD().initialize();
    ref.getRoom().then((value) {
      BackgroundService(rooms: value).monitorThreshold();
    });

  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocaleProvider localeProvider = LocaleProvider();
  ThemeProvider themeProvider = ThemeProvider();

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
    // localeProvider.initialize();
    // themeProvider.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => localeProvider),
        ChangeNotifierProvider(create: (context) => themeProvider),
      ],
      child: Consumer2<LocaleProvider, ThemeProvider>(
        builder: (context, localeProvider, themeProvider, child) {
          return GetMaterialApp(
            theme: themeProvider.currentTheme,
            supportedLocales: SupportLanguages.all,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: localeProvider.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: initScreen == 0 || initScreen == null ? OnBoarding.route_name : AuthReDirect.route_name,
            routes: {
              OnBoarding.route_name: (context) => OnBoarding(),
              AuthReDirect.route_name: (context) => AuthReDirect(),
              Setting.route_name: (context) => Setting(),
              Profile.route_name: (context) => Profile(),
              AboutUs.route_name: (context) => AboutUs(),
              Notifications.route_name: (context) => Notifications(),
              RoomCreate.route_name: (context) => RoomCreate(),
              DeviceScan.route_name: (context) => DeviceScan(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == RoomManagement.route_name) {
                final args = settings.arguments as Room;
                return MaterialPageRoute(
                  builder: (context) {
                    return RoomManagement(
                      room: args,
                    );
                  },
                );
              }
              if(settings.name == DeviceSetting.route_name) {
                final args = settings.arguments as Hardware_2_Room;
                return MaterialPageRoute(
                  builder: (context) {
                    return DeviceSetting(
                      hardware_2_room: args,
                    );
                  },
                );
              }
              assert(false, 'Need to implement ${settings.name}');
              return null;
            },
          );
        }
      ),
    );
  }
}
