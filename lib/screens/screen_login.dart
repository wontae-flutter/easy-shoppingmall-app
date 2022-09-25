import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EmailInput(),
              PasswordInput(),
              LoginButton(),
              Divider(thickness: 1),
              RegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}

//* TextField는 STL로 선언해도 내부의 OnChanged를 사용하거나 TextController를 사용하면 변화를 감지할 수 있습니다.
class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (email) {},
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          helperText: "이메일을 입력하세요.",
        ));
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (password) {},
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        helperText: "비밀번호를 입력하세요.",
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
        onPressed: () {},
        child: Text("Login"),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        "이메일로 간단하게 회원가입하기",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed("/register");
      },
    );
  }
}
