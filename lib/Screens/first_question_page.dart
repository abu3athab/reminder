import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Providers/navigation_provider.dart';

// ignore: must_be_immutable
class FirstQuestion extends StatelessWidget {
  FirstQuestion({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "How many free sms do you have every month",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            SizedBox(
                height: 60,
                width: 60,
                child: TextFormField(
                  controller: controller,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    label: Text("enter"),
                  ),
                )),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<NavigationProvider>(context, listen: false)
                    .setQuestionOneToTrue();
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