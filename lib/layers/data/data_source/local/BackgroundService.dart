import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:gfi/layers/data/data_source/remote/BlynkHTTPService.dart';
import 'package:gfi/layers/domain/entities/Room/Room.dart';

class BackgroundService {
  List<Room> rooms;

  BackgroundService({
    required this.rooms,
  });

  static void sendNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  void monitorThreshold() async {
    rooms.forEach((i) {
      i.hardware.forEach((k, v) async {
        Map<String, dynamic> result = await BlynkHTTPService(token: v.token).fetchData();
        if(result['mq2'] > result['mq2_threshold']) {
          sendNotification(
            'Warning',
            'From ${i.name} \nGas is over the safety threshold'
          );
          print('monitorThreshold higher');
        }
        if(result['mq2'] == result['mq2_threshold']) {
          sendNotification(
            'Warning',
            'From ${i.name} \nGas is near the safety threshold'
          );
          print('monitorThreshold equal');
        }
      });
    });
  }
}