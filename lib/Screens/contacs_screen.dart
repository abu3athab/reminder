import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:reminder/Controller/contact_controller.dart';
import 'package:reminder/Screens/contact_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact>? contacts;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      contacts = await ContactController().getContact();
      if (this.mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "***  Select your contacts  ***",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: (contacts) == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: contacts!.length,
                itemBuilder: (BuildContext context, int index) {
                  String num = (contacts![index].phones.isNotEmpty)
                      ? (contacts![index].phones.first.number)
                      : "--";
                  return ContactTile(
                    contact: contacts![index],
                  );
                },
              ));
  }
}
