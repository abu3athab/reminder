import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class SMSProvider extends ChangeNotifier {
  PermissionStatus isGranted = PermissionStatus.denied;

  Future<void> getPermission() async {
    isGranted = await Permission.sms.request();
    notifyListeners();
  }
}
