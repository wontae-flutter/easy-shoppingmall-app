import 'package:flutter/material.dart';
import "./screens/screens.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
    );
  }
}
