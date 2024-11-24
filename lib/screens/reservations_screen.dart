import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ReservationsScreen extends StatelessWidget {
  final TextEditingController _destinationController = TextEditingController();
  final ApiService _apiService = ApiService();

  ReservationsScreen({super.key});

  void _makeReservation(BuildContext context) async {
    try {
      await _apiService.makeReservation(
        'userId', // Este ID debe provenir del login
        'driverId', // Este ID debe provenir de la selección de un conductor
        _destinationController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva realizada con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al realizar la reserva')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservar viaje')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: 'Destino'),
            ),
            ElevatedButton(
              onPressed: () => _makeReservation(context),
              child: Text('Hacer reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
