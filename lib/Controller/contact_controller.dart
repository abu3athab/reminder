import 'dart:developer';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/contact_model.dart';
import 'package:flutter_sms/flutter_sms.dart';

class ContactController {
  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    } else {
      return [];
    }
  }

  Future<void> storeSelectedContacts(List<ContactModel> contacts) async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    obj.setStringList(
        'contacts', contacts.map((e) => json.encode(e.toJson())).toList());
  }

  Future<void> removeFromSelectedContacts(String? phoneNumber) async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.containsKey("contacts")) {
      List<ContactModel> contacts =
          json.decode(obj.getStringList("contacts").toString());
      contacts.removeWhere((element) => element.phoneNumber == phoneNumber);
      obj.setStringList(
          "contacts", contacts.map((e) => json.encode(e.toJson())).toList());
    } else {
      return;
    }
  }

  Future<List<ContactModel>> getStoredContacts() async {
    List<ContactModel> contacts = [];
    SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.containsKey("contacts")) {
      var data = json.decode(obj.getStringList('contacts').toString());
      for (var element in data) {
        contacts.add(ContactModel.fromJson(element));
      }
      return contacts;
    } else {
      return [];
    }
  }

  void sendSMSHelper(String message, List<String> recipents) async {
    _sendSMS(message, recipents);
  }

  void _sendSMS(String message, List<String> recipents) async {
    String result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      return (onError);
    });
    log(result);
  }
}
