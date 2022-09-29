//* Firebase와의 통신 등 인증 관련 회원 정보 전반을 다루는 모델
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:palestine_console/palestine_console.dart';

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail,
}

class FirebaseAuthProvider with ChangeNotifier {
  //* authClient: Firebase와 연결된 인스턴스를 저장할 변수
  //* 앱 전역에 똑같은 authClient를 유지, 제공할 수 있다
  FirebaseAuth authClient;
  //* 현재 로그인된 유저 객체를 저장하는 변수, 앱 전역으로 제공한다
  User? user;
  //! APP 전역으로 제공한다는 것, 로그인/로그아웃 상태가 변할 수 있다는 것 → ChangeNotifierProvider()
  //! 변하지 않으면 그냥 Provider()

  //* 문법 절대 이해 못하겠음
  FirebaseAuthProvider({auth}) : authClient = auth ?? FirebaseAuth.instance;

  //* FirebaseAuth가 제공하는 함수입니다
  Future<AuthStatus> registerWithEmail(String email, String password) async {
    try {
      UserCredential credential = await authClient
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthStatus.registerSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.registerFail;
    }
  }

  Future<AuthStatus> loginWithEmail(String email, String password) async {
    try {
      await authClient
          .signInWithEmailAndPassword(email: email, password: password)
          //* 인증정보를 담고있는 객체
          .then((credential) async {
        user = credential.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('email', email);
        //! 비밀번호 hash하는 패키지를 당연히 사용해야 합니다
        prefs.setString('password', password);
      });
      print("[+] 로그인유저 : " + user!.email.toString());
      return AuthStatus.loginSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.loginFail;
    }
  }

  //* 로그아웃 = 간단하게 모든 정보를 삭제하면 됩니다
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", false);
    prefs.setString("email", "");
    prefs.setString("password", "");
    user = null;
    await authClient.signOut();
    Print.red("로그아웃 되었습니다");
  }
}
