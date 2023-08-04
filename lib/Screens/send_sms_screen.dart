import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Models/contact_model.dart';
import 'package:reminder/Providers/contact_provider.dart';

class SendSmsScreen extends StatefulWidget {
  const SendSmsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SendSmsScreenState createState() => _SendSmsScreenState();
}

class _SendSmsScreenState extends State<SendSmsScreen> {
  List<ContactModel> contacts = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      Provider.of<ContactProvider>(context, listen: false)
          .loadStoredContactsDelegate();
      // ignore: unnecessary_this
      if (this.mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contacts = Provider.of<ContactProvider>(context, listen: true).contacts;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo)),
                onPressed: () async {
                  Provider.of<ContactProvider>(context, listen: false)
                      .sendSMSDelegate();
                },
                child: const Text("send SMS now"))
          ],
        ),
      ),
    );
  }
}
