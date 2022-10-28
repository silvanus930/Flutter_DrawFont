import 'package:hebrew/screens/WelComeScreen.dart';
import 'package:hebrew/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordProcessor',
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData(context),
      theme: lightThemeData(context),
      home: WelComeScreen(),
    );
  }
}
