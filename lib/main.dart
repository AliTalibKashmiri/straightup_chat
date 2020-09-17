import 'package:flutter/material.dart';
import 'package:straightup_chat/helper/authentication.dart';
import 'package:straightup_chat/views/signin.dart';
import 'package:straightup_chat/views/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F),

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Authentication(),
    );
  }
}



