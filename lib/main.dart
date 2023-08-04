import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Providers/contact_provider.dart';
import 'package:reminder/Providers/navigation_provider.dart';
import 'package:reminder/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:native_notify/native_notify.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NativeNotify.initialize(3259, 'eqtmK8gpBPEq9gmfRvWahB', null, null);
  runApp(const MyApp());
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
