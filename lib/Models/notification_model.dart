// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationModel {
  int id = 0;
  String? payload;
  String? title;
  String? body;

  tz.TZDateTime notificationScheduledTime = tz.TZDateTime.now(tz.local);

  NotificationModel({
    this.id = 0,
    this.payload,
    this.title,
    this.body,
    required this.notificationScheduledTime,
  });

  NotificationModel.defaultConstructor();

  NotificationModel.fromJson(Map<dynamic, String> json) {
    id = 0;
    payload = '';
    title = json['title'] ?? 'hello from ziker';
    body = json['body'] ?? 'a reminder to resend your sms msg';
    notificationScheduledTime = tz.TZDateTime.parse(
      tz.local,
      json['time'] ?? tz.TZDateTime.now(tz.local).toString(),
    );
  }

  toJson() {
    return {
      'id': 0,
      'payload': '',
      'title': title,
      'body': body,
      'time': notificationScheduledTime.toString(),
    };
  }
}
