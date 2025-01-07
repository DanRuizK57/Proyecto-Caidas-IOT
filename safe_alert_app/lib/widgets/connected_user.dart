import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:safe_alert_app/screens/alert_screen.dart';
import 'package:safe_alert_app/screens/map_screen.dart';
import 'package:safe_alert_app/services/mqqt_service.dart';
import 'package:safe_alert_app/services/normal_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectedUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.person),
            title: Text('Usuario conecta a thingsboard'),
            subtitle: Row(
              children: [
                AlertWidget(),
                SizedBox(
                  width: 20,
                ),
                LoadingAnimationWidget.flickr(
                    leftDotColor: Colors.green,
                    rightDotColor: Colors.blue,
                    size: 30),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(width: 8),
            TextButton(
              child: const Text('Ver ubicación'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlertScreen()),
              );
            },
            child: Text('Alerta')),
      ],
    );
  }

  // Widget alert() {
  //   //final MqttService mqttService = MqttService();
  //   final TelemetryService telemetryService = TelemetryService();
  //   return FutureBuilder<Map<String, dynamic>>(
  //     future: telemetryService.fetchTelemetryData(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return LoadingAnimationWidget.waveDots(color: Colors.grey, size: 30);
  //       } else if (snapshot.hasError) {
  //         return Text('Error de conexión');
  //       } else {
  //         final data = snapshot.data as Map<String, dynamic>;
  //         final buttonStat = data['datos']['buttonStat'] as List<dynamic>;

  //         if (buttonStat == 1) {
  //           return Text('Emergencia');
  //         } else {
  //           return Text('Conectado');
  //         }
  //         return Text('Conectado');
  //       }
  //     },
  //   );
  // }
}

class AlertWidget extends StatefulWidget {
  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  late TelemetryService telemetryService;
  Map<String, dynamic>? telemetryData;
  String val = '';

  @override
  void initState() {
    super.initState();
    telemetryService = TelemetryService();
    _startPeriodicFetch();
  }

  void _startPeriodicFetch() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        final data = await telemetryService.fetchTelemetryData();
        setState(() {
          telemetryData = data;
          final valData = data['datos']['buttonStat'] as List<dynamic>;
          if (valData.isNotEmpty) {
            val = valData[0]['value'].toString();
          } else {
            val = 'Sin datos';
          }
        });
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (telemetryData == null) {
      return LoadingAnimationWidget.waveDots(color: Colors.grey, size: 30);
    } else {
      return Text('Es emergencia: $val');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
