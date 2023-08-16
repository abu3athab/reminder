import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Controller/contact_controller.dart';
import 'package:reminder/Models/contact_model.dart';
import 'package:reminder/Providers/contact_provider.dart';
import 'package:reminder/Providers/recharge_date_provider.dart';
import 'package:reminder/Providers/sms_provider.dart';
import 'package:reminder/Screens/main_page.dart';
import 'package:reminder/Screens/on_board_page.dart';
import 'package:reminder/Screens/send_sms_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<ContactModel> contacts = [];
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        Provider.of<ContactProvider>(context, listen: false)
            .loadStoredContactsDelegate()
            .then((value) => Provider.of<SMSProvider>(context, listen: false)
                .getPermission())
            .then(
          (value) async {
            /*     if isSent==0 the user is new and has no data stored
                   if isSent==1 the user has data stored and sent his/her reminder message
                   if isSent==2 the user has data stored and he didn't send his next sms    */
            int isSent = await ContactController().isMessageSent();
            if (isSent == 1) {
              Future.delayed(Duration.zero).then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (Route<dynamic> route) => false),
              );
            } else if (isSent == 0) {
              Future.delayed(Duration.zero).then(
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoardPage(),
                    ),
                    (Route<dynamic> route) => false),
              );
            } else {
              Future.delayed(
                  Duration.zero,
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SendSmsScreen())));
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/hattab.jpeg"))),
            ),
            const SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
