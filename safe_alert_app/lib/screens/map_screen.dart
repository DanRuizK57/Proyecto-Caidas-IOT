import 'dart:collection';
import 'package:safe_alert_app/map/map_view.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación actual'),
      ),
      body: MapView(),
    );
  }
}
