import 'package:flutter/material.dart';
import 'pages/policy_number_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PolicyNumberPage(),
    );
  }
}
