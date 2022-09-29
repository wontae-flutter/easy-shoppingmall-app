import 'package:flutter/material.dart';

class SearchQueryProvider with ChangeNotifier {
  String text = "";

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }
}
