import "dart:async";
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//* 로그인 여부에 의해 login/index스크린으로 네비게이팅하는 페이지
//* 빌드 이전에 moveScreen()으로 여부를 결정해야하므로 initState()를 사용할 수 있게 stf

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogin = pref.getBool("isLogin") ?? false;
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin) {
      if (isLogin) {
        //* SplashScreen으로 돌아갈 일이 없기 때문에 Stack에서 제거해줍니다
        Navigator.of(context).pushReplacementNamed("/index");
      } else {
        Navigator.of(context).pushReplacementNamed("/login");
      }
    });
  }

  //* 본질적으로 login, index스크린이 다 빌드되었을 때 넘어가야하는게 아닌가?
  @override
  void initState() {
    super.initState();
    //* SplashScreen이 빌드되기 전에 initState()에서 준비를 해야합니다
    Timer(Duration(milliseconds: 1500), () {
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
