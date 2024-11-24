import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'register_screen.dart';
import 'reservations_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    try {
      final response = await ApiService().login(
        _emailController.text,
        _passwordController.text,
      );
      
      // Verificación para asegurar que la respuesta contiene un "token"
      if (response.containsKey('token')) {
        // Si la respuesta tiene un token, navega a la pantalla de reservas
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ReservationsScreen()),
        );
      } else {
        // Si la respuesta no contiene el token esperado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Respuesta inesperada')),
        );
      }
    } catch (e) {
      // Si ocurre un error en la solicitud
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
