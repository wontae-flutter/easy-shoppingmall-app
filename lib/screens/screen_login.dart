import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../models/model_login.dart";
import '../providers/provider_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFieldModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("로그인 스크린"),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              children: [
                EmailInput(),
                PasswordInput(),
                LoginButton(),
                RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);
    return TextField(
      onChanged: (email) {
        loginField.setEmail(email);
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: '이메일',
        helperText: '',
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);
    return TextField(
      onChanged: (password) {
        loginField.setPassword(password);
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: '비밀번호',
        helperText: '',
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  //* 버튼에서 auth가 이뤄지지 않습니까?
  //* 인풋에서는 데이터를 받아오기만 하죠
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<FirebaseAuthProvider>(context);
    final loginField = Provider.of<LoginFieldModel>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          await authClient
              .loginWithEmail(loginField.email, loginField.password)
              .then((loginStatus) async {
            if (loginStatus == AuthStatus.loginSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text("로그인 성공")));
              Navigator.pushReplacementNamed(context, '/index');
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text("로그인 실패")));
            }
          });
        },
        child: Text('로그인'),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/register');
      },
      child: Text(
        '이메일로 간단하게 회원가입 하기',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
