import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelemetryService {
  final String endpointUrl = 'http://10.0.2.2:3000/obtener-datos';

  // Método para obtener datos del endpoint
  Future<Map<String, dynamic>> fetchTelemetryData() async {
    try {
      final response = await http.get(Uri.parse(endpointUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Validar y procesar los datos
        if (data is Map<String, dynamic>) {
          debugPrint(data.toString());
          return data;
        } else {
          throw Exception('Formato de datos inválido.');
        }
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectarse al servidor: $e');
    }
  }
}

// Ejemplo de uso
// void main() async {
//   final telemetryService = TelemetryService();

//   try {
//     final data = await telemetryService.fetchTelemetryData();
//     print('Datos recibidos:');

//     // Procesar los datos según el formato
//     final valX = data['val_x'] as List<dynamic>;
//     final valY = data['val_y'] as List<dynamic>;
//     final buttonState = data['buttonState'] as List<dynamic>;

//     print('val_x: $valX');
//     print('val_y: $valY');
//     print('buttonState: $buttonState');
//   } catch (e) {
//     print('Error: $e');
//   }
// }
