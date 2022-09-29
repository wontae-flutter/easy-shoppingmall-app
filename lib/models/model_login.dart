//* 로그인 필드의 데이터를 관리하는 모델
//* Provider랑 합쳐놓았습니다. 밑에 메소드는 프로바이더로 가는 게 맞아요
//* Firebase와의 통신은 auth모델이 필수적으로 필요합니다.
import "package:flutter/material.dart";

class LoginFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
