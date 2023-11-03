import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class SchedulerController {
  Future<void> scheduleMonthlyNotification(int day) async {
    final DateTime now = DateTime.now();
    log("date now $now");
    tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local);

    scheduledDate = tz.TZDateTime(tz.local, now.year, now.month + 1, day, 20);
    log("time to sent the next notification:  $scheduledDate");
    SharedPreferences obj = await SharedPreferences.getInstance();
    obj.setString("time", scheduledDate.toString());
  }

  Future<tz.TZDateTime> getDateFromStorage() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    var scheduledDate = tz.TZDateTime.parse(
        tz.local,
        obj.getString("time") ??
            tz.TZDateTime(tz.local, DateTime.now().year + 1).toString());
    return scheduledDate;
  }

  Future<int> caluculateRemainingDays() async {
    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = await getDateFromStorage();
    int remainingDays = 1;

    remainingDays = scheduledDate.difference(now).inDays;
    if (remainingDays == 0) {
      SharedPreferences obj = await SharedPreferences.getInstance();
      obj.setInt("isSent", 2);
      SchedulerController().scheduleMonthlyNotification(now.day);
    }
    log("remaining days $remainingDays days");

    return remainingDays;
  }
}
