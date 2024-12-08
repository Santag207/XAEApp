import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingScreen extends StatefulWidget {
  @override
  _PendingScreenState createState() => _PendingScreenState();
}
class _PendingScreenState extends State<PendingScreen> {
  // Simulación de datos
  final Map<String, List<Map<String, dynamic>>> tareasPorSubsistema = {
    'Logística': [
      {'titulo': 'Organizar inventario', 'urgencia': '!', 'fecha': DateTime(2024, 12, 10), 'descripcion': ''},
      {'titulo': 'Gestionar transporte', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 15), 'descripcion': ''},
    ],
    'Mecánica': [
      {'titulo': 'Montar estructura', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 7), 'descripcion': ''},
      {'titulo': 'Ajustar motores', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 12), 'descripcion': ''},
    ],
    'Estrategia': [
      {'titulo': 'Definir estrategia de juego', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 9), 'descripcion': ''},
      {'titulo': 'Preparar presentaciones', 'urgencia': '!', 'fecha': DateTime(2024, 12, 14), 'descripcion': ''},
    ],
    'Programación': [
      {'titulo': 'Depurar código', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 8), 'descripcion': ''},
      {'titulo': 'Integrar sensores', 'urgencia': '!', 'fecha': DateTime(2024, 12, 13), 'descripcion': ''},
    ],
    'Drivers': [
      {'titulo': 'Practicar maniobras', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 6), 'descripcion': ''},
      {'titulo': 'Ajustar controles', 'urgencia': '!!!', 'fecha': DateTime(2024, 12, 10), 'descripcion': ''},
    ],
    'Redes Sociales': [
      {'titulo': 'Publicar contenido', 'urgencia': '!', 'fecha': DateTime(2024, 12, 7), 'descripcion': ''},
      {'titulo': 'Planificar campañas', 'urgencia': '!!', 'fecha': DateTime(2024, 12, 14), 'descripcion': ''},
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
          // Título de la pantalla
          Center(
            child: Text(
              'Lista de pendientes',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Subsistema: ',
                    style: TextStyle(
                      fontSize: 20, // Más grande para "Subsistema"
                      fontWeight: FontWeight.bold, // Texto en bold
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton<String>(
                    value: subsistemaSeleccionado,
                    dropdownColor: Colors.black,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Tamaño uniforme para los subsistemas
                      fontWeight: FontWeight.normal, // Texto en bold para el dropdown
                    ),
                    iconEnabledColor: Colors.red,
                    items: tareasPorSubsistema.keys.map((String subsistema) {
                      return DropdownMenuItem<String>(
                        value: subsistema,
                        child: Text(
                          subsistema,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setState(() {
                        subsistemaSeleccionado = nuevoValor ?? 'Mecánica';
                      });
                    },
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.menu, color: Colors.black),
                ),
                onSelected: (String value) {
                  if (value == 'Agregar') {
                    _showAgregarPendienteDialog();
                  } else if (value == 'Completar') {
                    _showCompletarPendienteDialog();
                  } else if (value == 'Notion') {
                    _showNotionDialog();
                  }

                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Agregar',
                    child: Text('Agregar pendiente'),
                  ),
                  PopupMenuItem(
                    value: 'Completar',
                    child: Text('Completar pendiente'),
                  ),
                  PopupMenuItem(
                    value: 'Notion',
                    child: Text('Abrir Notion'),
                  ),
                ],
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
                    style: TextStyle(
                      fontSize: 16, // Tamaño normal
                      fontWeight: FontWeight.normal, // Sin bold
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Fecha límite: ${_formatDate(tarea['fecha'])}',
                    style: TextStyle(
                      fontSize: 14, // Tamaño más grande para subtítulos
                      fontWeight: FontWeight.bold, // Subtítulo en bold
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => _mostrarDetallesPendiente(context, tarea, subsistemaSeleccionado),
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

  // Modal para agregar pendiente
  void _showAgregarPendienteDialog() {
    String? titulo, descripcion, urgencia = '!';
    DateTime? fechaSeleccionada;
    String subsistemaSeleccionadoAgregar = subsistemaSeleccionado;

    // Simulación del usuario logueado
    String nombreUsuario = "UsuarioActual";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                top: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título del formulario
                  Text(
                    'Agregar Pendiente',
                    style: TextStyle(
                      fontSize: 20, // Un poco más grande
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Selección de Subsistema
                  DropdownButton<String>(
                    value: subsistemaSeleccionadoAgregar,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                    iconEnabledColor: Colors.red,
                    items: tareasPorSubsistema.keys.map((String subsistema) {
                      return DropdownMenuItem<String>(
                        value: subsistema,
                        child: Text(subsistema, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setModalState(() {
                        subsistemaSeleccionadoAgregar = nuevoValor!;
                      });
                    },
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Campo de texto: Título
                  TextField(
                    style: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                    decoration: InputDecoration(
                      labelText: 'Título',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                    onChanged: (value) => titulo = value,
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Campo de texto: Descripción
                  TextField(
                    maxLines: 3,
                    style: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                    onChanged: (value) => descripcion = value,
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Nombre del creador
                  Text(
                    'Nombre del creador: $nombreUsuario',
                    style: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Selección de Prioridad
                  DropdownButton<String>(
                    value: urgencia,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                    iconEnabledColor: Colors.red,
                    items: ['!', '!!', '!!!'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Prioridad $value'),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setModalState(() {
                        urgencia = nuevoValor!;
                      });
                    },
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Botón para seleccionar la fecha
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Colors.red, // Color del botón "OK" y "CANCELAR"
                                onPrimary: Colors.white, // Color del texto en los botones
                                surface: Colors.black, // Fondo del calendario
                                onSurface: Colors.white, // Color de texto dentro del calendario
                              ),
                              dialogBackgroundColor: Colors.black, // Fondo del cuadro de diálogo
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        setModalState(() {
                          fechaSeleccionada = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      fechaSeleccionada == null
                          ? 'Seleccionar Fecha'
                          : 'Fecha: ${_formatDate(fechaSeleccionada)}',
                      style: TextStyle(color: Colors.white, fontSize: 16), // Tamaño uniforme
                    ),
                  ),
                  SizedBox(height: 16), // Espaciado entre elementos
                  // Botón Agregar
                  ElevatedButton(
                    onPressed: () {
                      if (titulo != null &&
                          descripcion != null &&
                          urgencia != null &&
                          fechaSeleccionada != null) {
                        setState(() {
                          tareasPorSubsistema[subsistemaSeleccionadoAgregar]!.add({
                            'titulo': titulo!,
                            'descripcion': descripcion!,
                            'urgencia': urgencia!,
                            'fecha': fechaSeleccionada!,
                            'nombreCreador': nombreUsuario, // Se agrega automáticamente el creador
                          });
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor completa todos los campos'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Agregar',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Modal para completar pendiente
  void _showCompletarPendienteDialog() {
    String subsistemaSeleccionadoCompletar = subsistemaSeleccionado;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final pendientes = tareasPorSubsistema[subsistemaSeleccionadoCompletar] ?? [];
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                top: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    'Completar Tareas',
                    style: TextStyle(
                      fontSize: 20, // Tamaño más grande para el título
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Texto "Subsistemas:"
                  Text(
                    'Subsistemas:',
                    style: TextStyle(
                      fontSize: 18, // Tamaño destacado
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Dropdown para seleccionar subsistema
                  DropdownButton<String>(
                    value: subsistemaSeleccionadoCompletar,
                    dropdownColor: Colors.black,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    iconEnabledColor: Colors.red,
                    items: tareasPorSubsistema.keys.map((String subsistema) {
                      return DropdownMenuItem<String>(
                        value: subsistema,
                        child: Text(
                          subsistema,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? nuevoValor) {
                      setModalState(() {
                        subsistemaSeleccionadoCompletar = nuevoValor!;
                      });
                    },
                  ),
                  SizedBox(height: 16),

                  // Lista de pendientes o mensaje de vacío
                  if (pendientes.isEmpty)
                    Text(
                      'No hay pendientes para este subsistema.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  else
                    ...pendientes.map((tarea) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Título de la tarea
                            Expanded(
                              child: Text(
                                tarea['titulo'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Botón "Completar"
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  pendientes.remove(tarea);
                                });
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Completar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showNotionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            '¿Quieres abrir el Notion?',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            // Botón "Sí"
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _openNotion(); // Llamar a la función de suscripción
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Sí', style: TextStyle(color: Colors.white)),
            ),
            // Botón "No"
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('No', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _openNotion() async {
    final Uri notionUrl = Uri.parse('https://www.notion.so/Javex-Robotics-13f4be11d8ed8012be7afa6b10bbf0d1?pvs=4');

    try {
      if (await canLaunchUrl(notionUrl)) {
        await launchUrl(
          notionUrl,
          mode: LaunchMode.externalApplication, // Abre en navegador o app externa
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Abriendo el calendario de pendientes en Notion...'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir el enlace. Verifica tu conexión.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error al intentar abrir el enlace: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error al abrir el enlace.'),
          backgroundColor: Colors.red,
        ),
      );
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
                'Pendientes para el ${_formatDate(selectedDay)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 10),
              if (tareasDelDia.isEmpty)
                Text(
                  'No hay pendientes para este día.',
                  style: TextStyle(color: Colors.white),
                )
              else
                ...tareasDelDia.map((tarea) {
                  final subsistema = tareasPorSubsistema.entries
                      .firstWhere((entry) => entry.value.contains(tarea))
                      .key;

                  return ListTile(
                    leading: Icon(Icons.warning, color: _getUrgenciaColor(tarea['urgencia'])),
                    title: Text(
                      '${tarea['titulo']} - ($subsistema)',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Urgencia: ${tarea['urgencia']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _mostrarDetallesPendiente(context, tarea, subsistema);
                    },
                  );
                }).toList(),
            ],
          ),
        );
      },
    );
  }

  // Modal para mostrar detalles de un pendiente seleccionado
  void _mostrarDetallesPendiente(BuildContext context, Map<String, dynamic> tarea, String subsistema) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado
              Text(
                'Detalles del Pendiente',
                style: TextStyle(
                  fontSize: 20, // Tamaño más grande para el título principal
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16), // Espaciado uniforme

              // Detalle: Título
              RichText(
                text: TextSpan(
                  text: 'Título: ', // Etiqueta en bold
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(
                      text: '${tarea['titulo']}', // Texto normal
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // Detalle: Subsistema
              RichText(
                text: TextSpan(
                  text: 'Subsistema: ', // Etiqueta en bold
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(
                      text: '$subsistema', // Texto normal
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // Detalle: Fecha límite
              RichText(
                text: TextSpan(
                  text: 'Fecha límite: ', // Etiqueta en bold
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(
                      text: '${_formatDate(tarea['fecha'])}', // Texto normal
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // Detalle: Creado por
              RichText(
                text: TextSpan(
                  text: 'Creado por: ', // Etiqueta en bold
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  children: [
                    TextSpan(
                      text: '${tarea['nombreCreador'] ?? 'Anónimo'}', // Texto normal
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // Detalle: Prioridad (Solo se ajusta el tamaño)
              Text(
                'Prioridad: ${tarea['urgencia']}',
                style: TextStyle(
                  fontSize: 20, // Tamaño ajustado
                  fontWeight: FontWeight.bold, // Texto en negrita
                  color: _getUrgenciaColor(tarea['urgencia']), // Color basado en la prioridad
                ),
              ),
            ],
          ),
        );
      },
    );
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
}
