import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            children: [
              LoginEmailInput(),
              LoginPasswordInput(),
              PasswordConfirmInput(),
              LoginRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginEmailInput extends StatelessWidget {
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

class LoginPasswordInput extends StatelessWidget {
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

class PasswordConfirmInput extends StatelessWidget {
  const PasswordConfirmInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (password) {},
      obscureText: true,
      decoration: InputDecoration(
        labelText: '비밀번호 확인',
        helperText: '',
      ),
    );
  }
}

class LoginRegisterButton extends StatelessWidget {
  const LoginRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("회원가입이 완료되었습니다.")));
          Navigator.pop(context);
        },
        child: Text('회원가입'),
      ),
    );
  }
}
