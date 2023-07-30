import 'package:flutter_contacts/flutter_contacts.dart';

class ContactController {
  Future<List<Contact>> getContact() async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    } else {
      return [];
    }
  }
}
