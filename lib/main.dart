import 'package:flutter/material.dart';
import 'package:quizproject/home.dart';
import 'package:quizproject/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AceRecruit App',
      debugShowCheckedModeBanner: false,
      home: Intro(),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}
