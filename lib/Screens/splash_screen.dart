import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Controller/contact_controller.dart';
import 'package:reminder/Models/contact_model.dart';
import 'package:reminder/Providers/contact_provider.dart';
import 'package:reminder/Providers/recharge_date_provider.dart';
import 'package:reminder/Screens/main_page.dart';
import 'package:reminder/Screens/on_board_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<ContactModel> contacts = [];
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      Provider.of<ContactProvider>(context, listen: false)
          .loadStoredContactsDelegate()
          .then((value) async {
        List contacts = await ContactController().getStoredContacts();
        if (contacts.isNotEmpty) {
          Future.delayed(Duration.zero).then(
            (value) async => await Provider.of<RechargeDateProvider>(context,
                    listen: false)
                .getRemainingDays()
                .then(
                  (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (Route<dynamic> route) => false),
                ),
          );
        } else {
          Future.delayed(Duration.zero)
              .then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnBoardPage(),
                  ),
                  (Route<dynamic> route) => false));
        }
      });
    });
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
