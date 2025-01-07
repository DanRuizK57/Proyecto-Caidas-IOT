import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:safe_alert_app/screens/alert_screen.dart';
import 'package:safe_alert_app/screens/map_screen.dart';

class FakeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Claudio Saez'),
          subtitle: Row(
            children: [
              Text('Dirección: Av. Siempre Viva 742'),
              SizedBox(
                width: 30,
              ),
              LoadingAnimationWidget.beat(color: Colors.red, size: 20),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
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
}
