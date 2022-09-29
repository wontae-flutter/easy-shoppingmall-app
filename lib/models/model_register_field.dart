//* 회원가입 폼에 포함되는 입력 필드를 모델화한 것 (Firebase와 아직까지는 관련 없음)
import 'package:flutter/material.dart';

class RegisterFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String passwordConfirm = "";

  //* 아래 함수들은 state를 변화시키고 consumer(=UI)에게 알려야 하기 때문에 notifyListerners()를 사용합니다.
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
    notifyListeners();
  }
}
