import 'package:flutter/material.dart';
import 'package:safe_alert_app/screens/home_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Alert',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(21, 33, 156, 44)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Safe Alert'),
      debugShowCheckedModeBanner: false,
    );
  }
}
