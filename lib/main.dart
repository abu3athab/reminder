// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Controller/notification_controller.dart';
import 'package:reminder/Providers/contact_provider.dart';
import 'package:reminder/Providers/navigation_provider.dart';
import 'package:reminder/Providers/recharge_date_provider.dart';
import 'package:reminder/Providers/sms_provider.dart';
import 'package:reminder/Screens/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController().initNotifications();
  tz.initializeTimeZones();
  Future.delayed(Duration.zero).then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await NotificationController()
          .showmy(title: "ahmed", body: "welcome again to ziker");
      // await NotificationController()
      //     .showScheduledNotifications(title: "hi", body: "yooooooo");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(create: (context) => RechargeDateProvider()),
        ChangeNotifierProvider(create: (context) => SMSProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
