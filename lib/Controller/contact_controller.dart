import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/contact_model.dart';

class ContactController {
  Future<List<Contact>> getContact() async {
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
    } else
      print("empty");
  }

  Future<void> getStoredContacts() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    if (obj.containsKey("contacts")) {
      var data = json.decode(obj.getStringList('contacts').toString());
      for (var element in data) {
        print(ContactModel.fromJson(element).phoneNumber);
      }
    }
  }
}
