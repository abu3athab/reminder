import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reminder/Controller/contact_controller.dart';

class SMSProvider extends ChangeNotifier {
  PermissionStatus isGranted = PermissionStatus.denied;
  int isSent = 0;
  Future<void> getPermission() async {
    isGranted = await Permission.sms.request();
    notifyListeners();
  }

  Future<void> isSentMsg() async {
    isSent = await ContactController().isMessageSent();
    notifyListeners();
  }
}
