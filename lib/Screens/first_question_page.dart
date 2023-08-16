import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Providers/contact_provider.dart';
import '../Providers/navigation_provider.dart';

// ignore: must_be_immutable
class FirstQuestionPage extends StatelessWidget {
  FirstQuestionPage({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      margin: EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.004),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(h * 0.012),
              child: const Text(
                "How many free sms do you have every month",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            SizedBox(
              height: h * 0.06,
              width: w * 0.06,
              child: TextFormField(
                controller: controller,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text(""),
                ),
                onFieldSubmitted: (value) {
                  if (controller.text.isNotEmpty) {
                    Provider.of<ContactProvider>(context, listen: false)
                        .numberOfAllowedContacts = int.parse(controller.text);
                    Provider.of<ContactProvider>(context, listen: false)
                        .numberOfRemainingContacts = int.parse(controller.text);
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setQuestionOneToTrue();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("field must not be empty"),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: h * 0.1,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Provider.of<ContactProvider>(context, listen: false)
                      .numberOfAllowedContacts = int.parse(controller.text);
                  Provider.of<ContactProvider>(context, listen: false)
                      .numberOfRemainingContacts = int.parse(controller.text);
                  Provider.of<NavigationProvider>(context, listen: false)
                      .setQuestionOneToTrue();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text("field must not be empty"),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo)),
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
