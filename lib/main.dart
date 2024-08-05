import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/policy_number_page.dart';

Future<void> main() async {
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }
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
