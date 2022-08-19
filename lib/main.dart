import 'package:flutter/material.dart';
import 'package:social_media_app/screens/sign_up_screen.dart';
import 'package:social_media_app/screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SignUpScreen(),
      routes: {
        SignInScreen.id : (context) => SignInScreen(),
        SignUpScreen.id : (context) => SignUpScreen(),
      },
    );
  }
}
