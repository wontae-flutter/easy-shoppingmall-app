import 'package:flutter/material.dart';
import '../providers/provider_auth.dart';
import '../models/model_register_field.dart';
import "package:provider/provider.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //* 하나의 프로바이더만 있으면 충분
      create: (_) => RegisterFieldModel(),
      child: Scaffold(
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
      ),
    );
  }
}

class LoginEmailInput extends StatelessWidget {
  //* TextInput에 새로운 인풋이 들어오면 인풋위젯만 리빌드됩니다.
  //* 인풋에 있는 값이 아직 state로 최종결정난게 아닙니다(사용자가 언제든 추가하거나 삭제할 수 있습니다)
  //* 그래서 불필요한 변화를 감지하지 않게 하는 listen:false
  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);

    return TextField(
      onChanged: (email) {
        // listen:fasle 옵션 때문에 밑의 ~가 나오기 전까지는...
        registerField.setEmail(email);
      },
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
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);

    return TextField(
      onChanged: (password) {
        registerField.setPassword(password);
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: '비밀번호',
        helperText: '',
      ),
    );
  }
}

//* Confirm은 실시간으로 비밀번호와 매치해서 오류를 내어야 하기 때문에
//* 인풋에서 받는 데이터가 바로바로 Provider에게 전달되어야 합니다 => listen: true
class PasswordConfirmInput extends StatelessWidget {
  const PasswordConfirmInput({super.key});

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: true);

    return TextField(
      onChanged: (password) {
        registerField.setPasswordConfirm(password);
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: '비밀번호 확인',
          helperText: '',
          errorText: registerField.password != registerField.passwordConfirm
              ? "비밀번호가 일치하지 않습니다."
              : null),
    );
  }
}

class LoginRegisterButton extends StatelessWidget {
  const LoginRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authClient =
        Provider.of<FirebaseAuthProvider>(context, listen: false);
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);

    //* 어...썅!
    //! listen: false은 UI에서 변화를 바로바로 감지하지 않겠다
    //!즉 블록으로 치면 프로바이더 패키지의 프로바이더는
    //! BlocProvider, BlocBuilder를 둘 다 제공하는데 BlocBuilder 기능을 끄는 것이다.
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
              .registerWithEmail(registerField.email, registerField.password)
              .then((registerStatus) {
            if (registerStatus == AuthStatus.registerSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text("회원가입이 완료되었습니다.")));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text("회원가입을 실패했습니다. 다시 시도해주세요.")));
              Navigator.pop(context);
            }
          });
        },
        child: Text('회원가입'),
      ),
    );
  }
}
