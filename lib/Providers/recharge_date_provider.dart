import 'package:flutter/material.dart';
import 'package:reminder/Controller/scheduler_controller.dart';

class RechargeDateProvider extends ChangeNotifier {
  int remainingDays = 0;

  Future<void> getRemainingDays() async {
    remainingDays = await SchedulerController().caluculateRemainingDays();
    notifyListeners();
  }
}
