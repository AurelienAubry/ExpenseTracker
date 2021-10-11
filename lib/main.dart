import 'package:flutter/material.dart';
import 'home.dart';

const darkBlue = const Color(0xFF2A2B90);
const lightBlue = const Color(0xFFF0F3FD);
const darkGrey = const Color(0xFF464646);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Tracker',
      home: HomePage(),
      theme: ThemeData(scaffoldBackgroundColor: lightBlue),
    );
  }
}