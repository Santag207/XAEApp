import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulación de datos
  final Map<String, List<Map<String, dynamic>>> tareasPorSubsistema = {
    'Logística': [
      {'titulo': 'Organizar inventario', 'urgencia': '!', 'fecha': DateTime(2024, 12, 10)},
      {'titulo': 'Gestionar transporte', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 15)},
    ],
    'Mecánica': [
      {'titulo': 'Montar estructura', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 7)},
      {'titulo': 'Ajustar motores', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 12)},
    ],
    'Estrategia': [
      {'titulo': 'Definir estrategia de juego', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 9)},
      {'titulo': 'Preparar presentaciones', 'urgencia': '!', 'fecha': DateTime(2024, 12, 14)},
    ],
    'Programación': [
      {'titulo': 'Depurar código', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 8)},
      {'titulo': 'Integrar sensores', 'urgencia': '!', 'fecha': DateTime(2024, 12, 13)},
    ],
    'Drivers': [
      {'titulo': 'Practicar maniobras', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 6)},
      {'titulo': 'Ajustar controles', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 10)},
    ],
    'Redes Sociales': [
      {'titulo': 'Publicar contenido', 'urgencia': '!', 'fecha': DateTime(2024, 12, 7)},
      {'titulo': 'Planificar campañas', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 14)},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Calcular el número total de tareas pendientes
    final totalTareasPendientes = tareasPorSubsistema.values.expand((tareas) => tareas).length;

    return Container(
      color: Colors.black, // Fondo negro
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centramos el contenido verticalmente
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo centrado en grande
          Center(
            child: Image.asset(
              'assets/logo.png', // Cambia esta ruta si es necesario
              height: 120,
            ),
          ),
          SizedBox(height: 20),
          // Título principal
          Center(
            child: Text(
              'Bienvenido al mejor semillero',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          // Número de tareas pendientes
          Center(
            child: Text(
              'Tareas pendientes: $totalTareasPendientes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
