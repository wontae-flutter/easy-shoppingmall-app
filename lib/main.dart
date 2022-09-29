import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:shoppingmall_app/providers/provider_auth.dart';
import 'package:shoppingmall_app/providers/provider_item.dart';
import 'package:shoppingmall_app/providers/provider_search_query.dart';
import "./screens/screens.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        //* 장바구니는 변화합니다
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        //* Search도 변화합니다. 한글자씩 늘어날때 변화하잖아요.
        ChangeNotifierProvider(create: (_) => SearchQueryProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/index': (context) => IndexScreen(),
          '/register': (context) => RegisterScreen(),
          '/item_search': (context) => ItemSearchScreen(),
          '/item_detail': (context) => ItemDetailScreen(),
        },
      ),
    );
  }
}
