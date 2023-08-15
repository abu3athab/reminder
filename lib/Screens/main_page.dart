import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/recharge_date_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController smsController = TextEditingController();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      await Provider.of<RechargeDateProvider>(context, listen: false)
          .getRemainingDays();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            "تذكير بالصلاة على الرسول",
            style: TextStyle(fontSize: w * 0.08, fontWeight: FontWeight.w500),
          )),
      body: Center(
        child: Column(children: [
          Container(
            width: w * 0.40,
            height: h * 0.40,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/hattab.jpeg"))),
          ),
          Text(
            "remaining days for next notification:${Provider.of<RechargeDateProvider>(context, listen: true).remainingDays}",
            style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w500),
          ),
        ]),
      ),
    );
  }
}
