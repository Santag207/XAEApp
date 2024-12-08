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

  // Lista de miembros activos
  final List<String> miembrosActivos = [
    'Juan Pérez',
    'María López',
    'Carlos García',
    'Ana Torres',
    'Santiago Castro',
    'Diana Rodríguez',
  ];

  @override
  Widget build(BuildContext context) {
    // Calcular el número total de tareas pendientes
    final totalTareasPendientes = tareasPorSubsistema.values.expand((tareas) => tareas).length;

    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título principal con padding superior
              Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: Center(
                  child: Text(
                    'Bienvenido de vuelta al semillero',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Logo centrado en grande
              Center(
                child: Image.asset(
                  'assets/logo.png', // Cambia esta ruta si es necesario
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              // Número de tareas pendientes
              Center(
                child: Text(
                  'Tareas pendientes: $totalTareasPendientes',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Negrita
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              // Subtítulo y lista de miembros activos
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Miembros en el Laboratorio:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Fondo blanco con bordes redondeados para la lista de miembros activos
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: ListView.builder(
                  shrinkWrap: true, // Permitir que la lista se ajuste a su contenido
                  physics: NeverScrollableScrollPhysics(), // Deshabilitar el scroll dentro del contenedor
                  itemCount: miembrosActivos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green, // Círculo verde
                      ),
                      title: Text(
                        miembrosActivos[index],
                        style: TextStyle(color: Colors.black), // Cambiar texto a negro
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
