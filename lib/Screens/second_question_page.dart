import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:reminder/Controller/scheduler_controller.dart';

import '../Providers/navigation_provider.dart';

class SecondQuestionPage extends StatefulWidget {
  const SecondQuestionPage({super.key});

  @override
  State<SecondQuestionPage> createState() => _SecondQuestionPageState();
}

class _SecondQuestionPageState extends State<SecondQuestionPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .setQuestionOneToFalse();
          },
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade300,
          ),
          margin:
              EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.001),
          child: SizedBox(
            height: h * 0.28,
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
              keyboardType: TextInputType.number,
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
