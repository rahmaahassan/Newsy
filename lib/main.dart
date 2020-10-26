import 'package:flutter/material.dart';

import 'views/home.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsy',
      theme: ThemeData(
        fontFamily: 'SFUIText',
        primaryColor: Colors.white,
      ),
      home: Home(),
    );
  }
}