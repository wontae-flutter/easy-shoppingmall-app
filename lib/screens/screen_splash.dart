import "dart:async";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_auth.dart';
import '../providers/provider_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:palestine_console/palestine_console.dart';

//* 로그인 여부에 의해 login/index스크린으로 네비게이팅하는 페이지
//! 로그인 되어있는 상태면 장바구니 상태를 불러옵니다
//* 빌드 이전에 moveScreen()으로 여부를 결정해야하므로 initState()를 사용할 수 있게 stf
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authClient =
        Provider.of<FirebaseAuthProvider>(context, listen: false);
    //* 장바구니는 처음 가져올 때는 ui가 변하지 않으니 listen: false

    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    bool isLogin = prefs.getBool("isLogin") ?? false;

    if (isLogin) {
      String email = prefs.getString("email")!;
      String password = prefs.getString("password")!;
      Print.white("저장된 정보로 로그인 재시도");
      await authClient.loginWithEmail(email, password).then((loginStatus) {
        if (loginStatus == AuthStatus.loginSuccess) {
          Print.green("로그인 성공");
          cartProvider.fetchCartItemsOrMakeCart(authClient.user);
        } else {
          Print.red("로그인 실패");
          isLogin = false;
          prefs.setBool("isLogin", false);
        }
      });
    }
    //* 이후에 로그인 페이지로 넘어갈지 안넘어갈지를 따로 정해줘야 할 것
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
