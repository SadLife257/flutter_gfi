import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  static void sendEmail(String address, String title, String body) async {
    final Email email = Email(
      body: body,
      subject: title,
      recipients: [address],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}