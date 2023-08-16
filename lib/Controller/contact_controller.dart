import 'dart:developer';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/contact_model.dart';
import 'package:flutter_sms/flutter_sms.dart';

class ContactController {
  Future<List<Contact>> getContactsFromUserDevice() async {
    //request permission to access contacts and check if permission is granted
    if (await FlutterContacts.requestPermission()) {
      //fetch contacts if the permission is granted
      return await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    } else {
      //if permission not granted an empty list is returned
      return [];
    }
  }

  //store user selected contatcs
  Future<void> storeSelectedContacts(List<ContactModel> contacts) async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    try {
      obj.setStringList(
          'contacts', contacts.map((e) => json.encode(e.toJson())).toList());
    } catch (e) {
      log(e.toString());
    }
  }

//remove contacts user unselected
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

  //retreive  user selected contacts from local storage
  Future<List<ContactModel>> getStoredContacts() async {
    List<ContactModel> contacts = [];

    try {
      SharedPreferences obj = await SharedPreferences.getInstance();
      if (obj.containsKey("contacts")) {
        var data = json.decode(obj.getStringList('contacts').toString());
        for (var element in data) {
          log("${element.runtimeType}jo");
          contacts.add(ContactModel.fromJson(element));
        }
      }
    } catch (e) {
      log("Error while fetching stored contacts: $e");
    }

    return contacts;
  }

  //helper function that calls the function that sends sms to users
  void sendSMSHelper(String message, List<String> recipents) async {
    _sendSMS(message, recipents);
  }

//function sends the selected users an sms
  void _sendSMS(String message, List<String> recipents) async {
    SharedPreferences obj = await SharedPreferences.getInstance();

    await sendSMS(message: message, recipients: recipents)
        .then((value) => obj.setInt("isSent", 1))
        .catchError((onError) {
      return (onError);
    });
  }

  Future<int> isMessageSent() async {
    SharedPreferences obj = await SharedPreferences.getInstance();

    if (obj.containsKey("isSent")) {
      return obj.getInt("isSent") ?? 0;
    } else {
      return 0;
    }
  }
}
