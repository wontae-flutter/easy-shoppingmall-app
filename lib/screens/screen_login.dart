import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (email) {},
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
    return TextField(
      onChanged: (password) {},
      obscureText: true,
      decoration: InputDecoration(
        labelText: '비밀번호',
        helperText: '',
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {},
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
