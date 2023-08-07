import 'dart:async';
import 'dart:developer';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Models/contact_model.dart';
import 'package:reminder/Providers/navigation_provider.dart';
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
  List<Contact>? contacts;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      contacts = await ContactController().getContactsFromUserDevice();
      if (mounted) {
        setState(() {});
      }
    });
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  isThird()
                      ? SizedBox(
                          width: width * 0.7,
                          child: TextField(
                            cursorColor: Colors.grey,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              hintText: 'Search events by their name',
                            ),
                            onChanged: (value) {
                              log(searchText);
                              setState(() {
                                searchText = value;
                              });
                            },
                            style: const TextStyle(fontSize: 15),
                          ),
                        )
                      : const SizedBox(),
                  if (isFirst())
                    FirstQuestion()
                  else if (isSecond())
                    secondQuestion()
                  else if (isThird())
                    (contacts) == null
                        ? const Center(child: CircularProgressIndicator())
                        : Flexible(
                            child: ListView.builder(
                              itemCount: contacts!.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == contacts!.length - 1) {
                                  ContactModel contact = ContactModel(
                                      firstName:
                                          contacts?[index].name.first ?? "",
                                      lastName:
                                          contacts?[index].name.last ?? "",
                                      phoneNumber: contacts?[index]
                                              .phones
                                              .firstOrNull
                                              ?.number ??
                                          "",
                                      photo: contacts?[index].photo);
                                  return Column(
                                    children: [
                                      ContactTile(
                                        contact: contact,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const SendSmsScreen()));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.indigo),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                        child: const Text("submit"),
                                      ),
                                    ],
                                  );
                                } else if (contacts![index]
                                    .name
                                    .first
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
                                  return ContactTile(contact: contact);
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
                                  return ContactTile(contact: contact);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color:
                          Provider.of<NavigationProvider>(context, listen: true)
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
                      color:
                          Provider.of<NavigationProvider>(context, listen: true)
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
                      color:
                          Provider.of<NavigationProvider>(context, listen: true)
                                  .thirdQuestionIsDone
                              ? Colors.indigo
                              : Colors.white,
                      border: Border.all(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget secondQuestion() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade300,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: SizedBox(
            height: 280,
            child: Center(
                child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter your expected recharge date",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              maxLength: 2,
            )),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.indigo)),
          onPressed: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .setQuestionTwoToTrue();
          },
          child: const Text("Next"),
        )
      ],
    );
  }
}
