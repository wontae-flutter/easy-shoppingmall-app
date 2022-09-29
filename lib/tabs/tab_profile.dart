import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../providers/provider_auth.dart';

//* 로그인, 로그아웃과 관련된 기능이면 FirebaseAuthProvider가 필요할 테고
//* Provider 패키지도 사용해야 한다
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<FirebaseAuthProvider>(context, listen: false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile"),
          TextButton(
            onPressed: () async {
              await authProvider.logout().then((_) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text("로그아웃 되었습니다.")));
              });
              Navigator.of(context).pushReplacementNamed("/login");
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
