import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:safe_alert_app/screens/alert_screen.dart';
import 'package:safe_alert_app/screens/map_screen.dart';
import 'package:safe_alert_app/services/mqqt_service.dart';
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
                alert(),
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

  Widget alert() {
    final MqttService mqttService = MqttService();
    return FutureBuilder<bool>(
      future: mqttService.connect(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimationWidget.waveDots(color: Colors.grey, size: 30);
        } else if (snapshot.hasError || !(snapshot.data ?? false)) {
          return Text('Error de conexión');
        } else {
          return Text('Conectado');
        }
      },
    );
  }
}
