import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(-38.74635151915847,
            -72.61719169809592), // Center the map over London
        initialZoom: 16,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse(
                  'https://openstreetmap.org/copyright')), // (external)
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(-38.74635151915847, -72.61719169809592),
              width: 80,
              height: 80,
              child: LoadingAnimationWidget.beat(color: Colors.red, size: 20),
            )
          ],
        )
      ],
    );
  }
}
