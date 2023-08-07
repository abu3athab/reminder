import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Controller/notification_controller.dart';
import 'package:reminder/Providers/contact_provider.dart';
import 'package:reminder/Providers/navigation_provider.dart';
import 'package:reminder/Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController()
      .initNotifications()
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
