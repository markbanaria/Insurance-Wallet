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
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA), // White background for all pages
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[800], // Dark blue background color for the AppBar
          titleTextStyle: TextStyle(
            color: Colors.white, // White text color for the AppBar title
            fontSize: 16, // Title font size
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // White color for icons in the AppBar
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Blue background color for ElevatedButton
            foregroundColor: Colors.white, // White text color for ElevatedButton
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Optional padding
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red, // Blue text color for TextButton
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red, // Blue text color for OutlinedButton
            side: BorderSide(color: Colors.red), // Blue border color
          ),
        ),
      ),
      home: PolicyNumberPage(),
    );
  }
}
