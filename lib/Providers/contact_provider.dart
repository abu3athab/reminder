import 'package:flutter/material.dart';
import 'package:reminder/Controller/contact_controller.dart';
import 'package:reminder/Models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contacts = [];
  int numberOfAllowedContacts = 0;
  int numberOfSelectedContacts = 0;
  int numberOfRemainingContacts = 0;

  /*
  delegate to call the function that retreives  contatcs 
  from local storage and store them into a list of contacts
  */
  Future<void> loadStoredContactsDelegate() async {
    contacts = await ContactController().getStoredContacts();
    notifyListeners();
  }

  Future<void> addContact(ContactModel contact) async {
    contacts.add(contact);
    numberOfSelectedContacts++;
    numberOfRemainingContacts--;
    await ContactController().storeSelectedContacts(contacts);

    notifyListeners();
  }

  Future<void> removeContact(ContactModel contact) async {
    contacts
        .removeWhere((element) => element.phoneNumber == contact.phoneNumber);
    numberOfSelectedContacts--;
    numberOfRemainingContacts++;
    await ContactController().storeSelectedContacts(contacts);
    notifyListeners();
  }

  void sendSMSDelegate() {
    List<String> recipents = [];
    for (var element in contacts) {
      recipents.add(element.phoneNumber ?? "");
    }
    ContactController().sendSMSHelper(
        'عطر لسانك بالصلاة والسلام على النبي محمد ﷺ:From Ahmed Alkhatib',
        recipents);
  }
}
