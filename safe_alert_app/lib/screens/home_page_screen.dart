import 'package:flutter/material.dart';
import 'package:safe_alert_app/screens/alert_screen.dart';
import 'package:safe_alert_app/screens/map_screen.dart';
import 'package:safe_alert_app/widgets/connected_user.dart';
import 'package:safe_alert_app/widgets/fake_user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [FakeUser(), ConnectedUser()],
        ));
  }
}
