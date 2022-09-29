import "package:flutter/material.dart";
import '../models/model_login_field.dart';

class LoginFieldProvider extends ChangeNotifier {
  late String email;
  late String password;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
