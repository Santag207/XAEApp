import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  String subsistemaSeleccionado = 'Logística'; // Subsistema inicial seleccionado
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    // Obtener las tareas filtradas por subsistema
    final tareasSeleccionadas = tareasPorSubsistema[subsistemaSeleccionado] ?? [];

    return Container(
      color: Colors.black, // Fondo negro
      padding: EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bienvenida
          Center(
            child: Text(
              'Bienvenido de vuelta',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          // Horas trabajadas
          Text(
            _getHorasTrabajadasText(35), // Cambia según las horas trabajadas
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          // Título de tareas pendientes
          Text(
            'Lista de tareas pendientes:',
            style: TextStyle(
              fontSize: 22, // Más grande
              fontWeight: FontWeight.bold, // Negrilla
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          // Dropdown para seleccionar subsistema
          Row(
            children: [
              Text(
                'Subsistema: ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              DropdownButton<String>(
                value: subsistemaSeleccionado,
                dropdownColor: Colors.black,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.red,
                items: tareasPorSubsistema.keys.map((String subsistema) {
                  return DropdownMenuItem<String>(
                    value: subsistema,
                    child: Text(subsistema, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    subsistemaSeleccionado = nuevoValor ?? 'Logística';
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          // Mostrar tareas filtradas por subsistema
          Expanded(
            child: ListView.builder(
              itemCount: tareasSeleccionadas.length,
              itemBuilder: (context, index) {
                final tarea = tareasSeleccionadas[index];
                return ListTile(
                  leading: Icon(Icons.warning, color: _getUrgenciaColor(tarea['urgencia'])),
                  title: Text(
                    '${tarea['titulo']} (${tarea['urgencia']})',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Fecha límite: ${_formatDate(tarea['fecha'])}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          // Calendario del mes actual
          Text(
            'Calendario:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selectedDayNew, focusedDayNew) {
              setState(() {
                selectedDay = selectedDayNew;
                focusedDay = focusedDayNew;

                // Mostrar el modal con las tareas del día seleccionado
                _mostrarTareasDelDia(context);
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.red),
              outsideDaysVisible: false,
            ),
            eventLoader: (day) {
              final todasLasTareas = tareasPorSubsistema.values.expand((tareas) => tareas).toList();
              final tareasDelDia = todasLasTareas.where((tarea) => isSameDay(tarea['fecha'], day)).toList();
              return tareasDelDia;
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  // Determinar el color del marcador por nivel de urgencia
                  final tareasDelDia = events as List<Map<String, dynamic>>;
                  final urgenciaMasAlta = tareasDelDia.map((tarea) => tarea['urgencia'] as String).reduce(
                        (a, b) => _getUrgenciaPeso(a) > _getUrgenciaPeso(b) ? a : b,
                  );

                  return Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getUrgenciaColor(urgenciaMasAlta),
                      shape: BoxShape.circle,
                    ),
                  );
                }
                return null;
              },
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
              formatButtonVisible: false,
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Texto dinámico para horas trabajadas
  String _getHorasTrabajadasText(int horas) {
    if (horas == 0) {
      return 'Vamos, trabajaste 0 horas, apoya más al equipo.';
    } else {
      return 'Has trabajado una cantidad de $horas horas, ¡sigue así!';
    }
  }

  // Modal para mostrar tareas del día seleccionado
  void _mostrarTareasDelDia(BuildContext context) {
    final todasLasTareas = tareasPorSubsistema.values.expand((tareas) => tareas).toList();
    final tareasDelDia = todasLasTareas.where((tarea) => isSameDay(tarea['fecha'], selectedDay)).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tareas para el ${_formatDate(selectedDay)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 10),
              if (tareasDelDia.isEmpty)
                Text(
                  'No hay tareas para este día.',
                  style: TextStyle(color: Colors.white),
                )
              else
                ...tareasDelDia.map((tarea) {
                  // Buscar el subsistema al que pertenece la tarea
                  final subsistema = tareasPorSubsistema.entries
                      .firstWhere((entry) => entry.value.contains(tarea))
                      .key;

                  return ListTile(
                    leading: Icon(Icons.warning, color: _getUrgenciaColor(tarea['urgencia'])),
                    title: Text(
                      '${tarea['titulo']} - ($subsistema)', // Agregar subsistema al título
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Urgencia: ${tarea['urgencia']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
            ],
          ),
        );
      },
    );
  }


// Obtener peso para evaluar urgencia
  int _getUrgenciaPeso(String urgencia) {
    switch (urgencia) {
      case '!':
        return 1; // Menos urgente
      case '!!':
        return 2; // Urgencia media
      case '!!!':
        return 3; // Más urgente
      default:
        return 0; // Sin urgencia
    }
  }

// Colores según la urgencia
  Color _getUrgenciaColor(String urgencia) {
    switch (urgencia) {
      case '!':
        return Colors.green;
      case '!!':
        return Colors.yellow;
      case '!!!':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

// Formato de fecha
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
}
