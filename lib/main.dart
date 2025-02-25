import 'package:batterydoctor/authentication/auth_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF00bfa5),
          // accentColor: Color(0xFF616161),
          accentColor: Colors.lightGreen,
          textTheme: TextTheme()),
      home: AuthService().handleAuth(),
    );
  }
}
