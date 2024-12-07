import 'package:flutter/material.dart';
import 'menu_screen.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    // Simulación de autenticación con verificación de correo
    if (email == 'prueba@correo.com' && password == '1') {
      // Aquí simulamos que el correo está verificado
      final isEmailVerified = true;

      if (isEmailVerified) {
        // Navega a la pantalla de inicio si el correo está verificado
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen()), // Pantalla principal
        );
      } else {
        // Muestra un mensaje si el correo no está verificado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, verifica tu correo electrónico.')),
        );
      }
    } else {
      // Muestra un mensaje si las credenciales son incorrectas
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correo o contraseña incorrectos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro para toda la pantalla
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo en la parte superior
              Image.asset(
                'assets/logo.png',
                height: 220,
                width: 220,
              ),
              SizedBox(height: 20),
              // Contenedor con fondo blanco, bordes redondeados y borde negro
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      'Javex Robotics',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _login(context),
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
