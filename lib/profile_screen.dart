import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> dummyData = {
    'nombre': 'Juan Pérez',
    'carrera': 'Ingeniería Mecatrónica',
    'edad': 21,
    'rango': 'A1',
    'cumpleanos': '2001-01-15'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${dummyData['nombre']}'),
            Text('Carrera: ${dummyData['carrera']}'),
            Text('Edad: ${dummyData['edad']}'),
            Text('Rango: ${dummyData['rango']}'),
            Text('Cumpleaños: ${dummyData['cumpleanos']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Simulación: Editar Perfil')),
                );
              },
              child: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
