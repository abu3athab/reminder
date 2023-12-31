import 'dart:async';
import 'dart:developer';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Models/contact_model.dart';
import 'package:reminder/Providers/contact_provider.dart';
import 'package:reminder/Providers/navigation_provider.dart';
import 'package:reminder/Screens/second_question_page.dart';
import 'package:reminder/Screens/send_sms_screen.dart';
import '../Controller/contact_controller.dart';
import 'contact_tile.dart';
import 'first_question_page.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  double progress = 0.0;

  String searchText = '';
  var search = TextEditingController();

  List<Contact>? contacts;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      contacts = await ContactController().getContactsFromUserDevice();
      if (mounted) {
        setState(() {});
      }
    });
    search.addListener(() {});
    super.initState();
  }

  bool isFirst() {
    if (!Provider.of<NavigationProvider>(context, listen: true)
            .firstQuestionIsDone &&
        !Provider.of<NavigationProvider>(context, listen: true)
            .secondQuestionIsDone &&
        !Provider.of<NavigationProvider>(context, listen: true)
            .thirdQuestionIsDone) {
      return true;
    } else {
      return false;
    }
  }

  bool isSecond() {
    if (Provider.of<NavigationProvider>(context, listen: true)
            .firstQuestionIsDone &&
        !Provider.of<NavigationProvider>(context, listen: true)
            .secondQuestionIsDone &&
        !Provider.of<NavigationProvider>(context, listen: true)
            .thirdQuestionIsDone) {
      return true;
    } else {
      return false;
    }
  }

  bool isThird() {
    if (Provider.of<NavigationProvider>(context, listen: true)
            .firstQuestionIsDone &&
        Provider.of<NavigationProvider>(context, listen: true)
            .secondQuestionIsDone &&
        !Provider.of<NavigationProvider>(context, listen: true)
            .thirdQuestionIsDone) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: isThird()
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "remaining remaining contacts: ${Provider.of<ContactProvider>(context, listen: true).numberOfRemainingContacts}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Provider.of<NavigationProvider>(context,
                                        listen: true)
                                    .firstQuestionIsDone
                                ? Colors.indigo
                                : Colors.white,
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Provider.of<NavigationProvider>(context,
                                        listen: true)
                                    .secondQuestionIsDone
                                ? Colors.indigo
                                : Colors.white,
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Provider.of<NavigationProvider>(context,
                                        listen: true)
                                    .thirdQuestionIsDone
                                ? Colors.indigo
                                : Colors.white,
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Provider.of<NavigationProvider>(context,
                                        listen: true)
                                    .firstQuestionIsDone
                                ? Colors.indigo
                                : Colors.white,
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Provider.of<NavigationProvider>(context,
                                        listen: true)
                                    .secondQuestionIsDone
                                ? Colors.indigo
                                : Colors.white,
                            border: Border.all(color: Colors.indigo),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Provider.of<NavigationProvider>(context,
                                      listen: true)
                                  .thirdQuestionIsDone
                              ? Colors.indigo
                              : Colors.white,
                          border: Border.all(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  isThird()
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Provider.of<NavigationProvider>(context,
                                          listen: false)
                                      .setQuestionTwoToFalse();
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                            SizedBox(
                              width: width * 0.7,
                              child: TextField(
                                cursorColor: Colors.grey,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1)),
                                  hintText: 'Search events by their name',
                                ),
                                onChanged: (value) {
                                  log(searchText.isEmpty ? "hi" : searchText);
                                  searchText = value;
                                  setState(() {});
                                },
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  if (isFirst())
                    const FirstQuestionPage()
                  else if (isSecond())
                    const SecondQuestionPage()
                  else if (isThird())
                    (contacts) == null
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                              itemCount: contacts!.length,
                              itemBuilder: (BuildContext context, int index) {
                                String fullName =
                                    "${contacts![index].name.first} ${contacts![index].name.last}";

                                if (fullName
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()) ||
                                    fullName
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase())) {
                                  ContactModel contact = ContactModel(
                                      lastName:
                                          contacts?[index].name.last ?? "",
                                      firstName: contacts?[index].name.first ??
                                          "no name found",
                                      phoneNumber: contacts?[index]
                                              .phones
                                              .firstOrNull
                                              ?.number ??
                                          "no number found",
                                      photo: contacts?[index].photo);
                                  return ContactTile(
                                    contact: contact,
                                  );
                                } else if (searchText.isEmpty) {
                                  ContactModel contact = ContactModel(
                                      lastName:
                                          contacts?[index].name.last ?? "",
                                      firstName: contacts?[index].name.first ??
                                          "no name found",
                                      phoneNumber: contacts?[index]
                                              .phones
                                              .firstOrNull
                                              ?.number ??
                                          "no number found",
                                      photo: contacts?[index].photo);
                                  return ContactTile(
                                    contact: contact,
                                  );
                                } else if (!fullName
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase())) {
                                  return Container(
                                    color: Colors.white,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                  isThird()
                      ? ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const SendSmsScreen()));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: const Text("submit"),
                        )
                      : Container()
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
