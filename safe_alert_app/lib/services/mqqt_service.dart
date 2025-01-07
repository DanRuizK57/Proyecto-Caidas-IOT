import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MqttService {
  final String mqttBroker = 'iot.ceisufro.cl';
  final int mqttPort = 1883;
  final String accessToken = 'bket293EjRcPjaZp9NT6';
  final String topic = 'v1/devices/me/telemetry';

  late MqttServerClient client;

  MqttService() {
    client = MqttServerClient(mqttBroker, '');
    client.port = mqttPort;
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onUnsubscribed =
        (String? topic) => print('Desuscrito del tema: $topic');
    client.onSubscribeFail =
        (String? topic) => print('Error al suscribirse al tema: $topic');
    client.pongCallback = pong; // Callback para ping-pong
  }

  Future<bool> connect() async {
    try {
      client.connectionMessage = MqttConnectMessage()
          .authenticateAs(accessToken, '')
          .startClean()
          .withWillQos(MqttQos.atMostOnce);

      await client.connect();

      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        return true;
      } else {
        client.disconnect();
        return false;
      }
    } catch (e) {
      client.disconnect();
      return false;
    }
  }

  void disconnect() {
    print('Desconectando...');
    client.disconnect();
  }

  void onConnected() {
    print('Conexión exitosa.');
  }

  void onDisconnected() {
    print('Desconectado del broker.');
  }

  void onSubscribed(String topic) {
    print('Suscrito al tema: $topic');
  }

  void pong() {
    print('Respuesta PING recibida.');
  }

  void listen() {
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
      final MqttPublishMessage message = c![0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Mensaje recibido en el tema ${c[0].topic}: $payload');

      final telemetryData = jsonDecode(payload);
      print('Datos de telemetría: $telemetryData');
    });
  }
}
