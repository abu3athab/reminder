import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  bool firstQuestionIsDone = false;
  bool secondQuestionIsDone = false;
  bool thirdQuestionIsDone = false;

  void setQuestionOneToTrue() {
    firstQuestionIsDone = true;
    notifyListeners();
  }

  void setQuestionTwoToTrue() {
    secondQuestionIsDone = true;
    notifyListeners();
  }

  void setQuestionThreeToTrue() {
    thirdQuestionIsDone = true;
    notifyListeners();
  }

  void setQuestionOneToFalse() {
    firstQuestionIsDone = false;
    notifyListeners();
  }

  void setQuestionTwoToFalse() {
    secondQuestionIsDone = false;
    notifyListeners();
  }
}
