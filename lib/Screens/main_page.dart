import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:reminder/Screens/contacs_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController smsController = TextEditingController();

  PhoneContact? contact;

  String? contactName;

  String? contactNumber;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.green,
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
            "Number of free sms messages",
            style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: h * 0.02),
            width: w * 0.15,
            height: h * 0.15,
            child: TextField(
              controller: smsController,
              cursorColor: Colors.green,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => ContactScreen()));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            child: const Text("press me"),
          ),
          Text("name:$contactName, number: $contactNumber")
        ]),
      ),
    );
  }
}
