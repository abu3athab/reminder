import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/contact_model.dart';
import 'package:flutter_sms/flutter_sms.dart';

//test
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

//function sends the selected users an sms
  Future<bool> sendSMSMsg(
      String message, List<String> recipents, bool isGranted) async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    bool canSend = await canSendSMS();
    bool flag = false;
    print("can send ?:c $canSend");
    if (Platform.isAndroid && isGranted && canSend) {
      await sendSMS(message: message, recipients: recipents, sendDirect: false)
          .then((value) {
        if (value == "sent") {
          obj.setInt("isSent", 1);
          flag = true;
        }
      }).catchError((onError) {
        flag = false;
      });
    } else if (Platform.isAndroid && isGranted && !canSend) {
      if (await sendSMSForAndroid(phoneNumbers: recipents, message: message)) {
        flag = true;
        obj.setInt("isSent", 1);
      } else {
        flag = false;
      }
    } else if (Platform.isIOS && canSend) {
      await sendSMS(message: message, recipients: recipents, sendDirect: true)
          .then((value) {
        if (value == "sent") {
          obj.setInt("isSent", 1);
          flag = true;
        }
      }).catchError((onError) {
        flag = false;
      });
    } else {
      flag = false;
    }

    return flag;
  }

  Future<bool> sendSMSForAndroid(
      {required List<String> phoneNumbers, required String message}) async {
    bool flag = false;
    const platform = MethodChannel('com.example.reminder');
    print(message);
    print(phoneNumbers);
    try {
      var result = await platform.invokeMethod('sendSMS', {
        'phoneNumbers': phoneNumbers,
        'message': message,
      });
      if (result == "SMS sent successfully.") {
        flag = true;
      } else {
        flag = false;
      }
    } on PlatformException catch (e) {
      print("Error: ${e.toString()} !!!");
      flag = false;
    }
    return flag;
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
