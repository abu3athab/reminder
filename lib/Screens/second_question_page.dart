import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Controller/scheduler_controller.dart';

import '../Providers/navigation_provider.dart';

// ignore: must_be_immutable
class SecondQuestionPage extends StatelessWidget {
  SecondQuestionPage({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              controller: controller,
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
          onPressed: () async {
            if (controller.text.isNotEmpty) {
              await SchedulerController()
                  .scheduleMonthlyNotification(int.parse(controller.text))
                  .then((value) =>
                      Provider.of<NavigationProvider>(context, listen: false)
                          .setQuestionTwoToTrue());
            }
          },
          child: const Text("Next"),
        ),
      ],
    );
  }
}
