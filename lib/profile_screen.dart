import 'package:flutter/material.dart';
import 'add_hours_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> dummyData = {
    'nombre': 'Santiago',
    'apellidos': 'Castro Zuluaga',
    'fechaUnion': '10/04/2024',
    'rango': 'VRC',
    'tareasCompletadas': 35,
    'tareasCreadas': 20,
    'horasTrabajadas': 120,
    'subsistemas': ['Logística', 'Estrategia', 'Drivers'],
    'liderSubsistema': 'Logística',
  };

  final List<String> allSubsistemas = [
    'Logística',
    'Mecánica',
    'Programación',
    'Estrategia',
    'Drivers',
    'Redes Sociales',
    'Junta',
  ];

  bool isActive = false; // Estado del perfil: activo o no

  void _showEditModal(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: dummyData['nombre']);
    TextEditingController lastNameController = TextEditingController(text: dummyData['apellidos']);
    List<String> selectedSubsistemas = List<String>.from(dummyData['subsistemas']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Editar Perfil',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: lastNameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Subsistemas:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: allSubsistemas.map((subsistema) {
                      final isSelected = selectedSubsistemas.contains(subsistema);
                      return FilterChip(
                        label: Text(
                          subsistema,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Colors.red,
                        backgroundColor: Colors.grey[800],
                        onSelected: (bool selected) {
                          setModalState(() {
                            if (selected) {
                              selectedSubsistemas.add(subsistema);
                            } else {
                              selectedSubsistemas.remove(subsistema);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        dummyData['nombre'] = nameController.text;
                        dummyData['apellidos'] = lastNameController.text;
                        dummyData['subsistemas'] = selectedSubsistemas;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Center(
                      child: Text(
                        'Guardar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            'Perfil',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  // Circulo indicador de estado
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.grey[400], // Verde si está activo, gris claro si no
                      shape: BoxShape.circle,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.grey[800],
                      child: Image.asset(
                        'assets/profile_picture.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        dummyData['nombre'] ?? 'Nombre desconocido',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        dummyData['apellidos'] ?? 'Apellidos desconocidos',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Fecha de unión: ${dummyData['fechaUnion'] ?? 'N/A'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Rango: ${dummyData['rango'] ?? 'N/A'}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 10),
                            if (dummyData['subsistemas'] != null &&
                                (dummyData['subsistemas'] as List).isNotEmpty)
                              Text(
                                'Subsistemas: ${(dummyData['subsistemas'] as List).join(', ')}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (dummyData['liderSubsistema'] != null)
                              Text(
                                'Líder del subsistema de ${dummyData['liderSubsistema']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: IconButton(
                            onPressed: () => _showEditModal(context),
                            icon: Icon(Icons.edit, color: Colors.white),
                            iconSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Ajuste del padding para el Divider
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8), // Agregar espacio debajo de la línea
                    child: Divider(color: Colors.white, thickness: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              dummyData['tareasCompletadas']?.toString() ?? '0',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tareas\nCompletadas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              dummyData['tareasCreadas']?.toString() ?? '0',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tareas\nCreadas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              dummyData['horasTrabajadas']?.toString() ?? '0',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Horas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.white, thickness: 1),
                  Text(
                    'Tareas completadas por subsistema:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.5,
                    children: [
                      _buildSubsystemCard('Logística', '12 tareas'),
                      _buildSubsystemCard('Mecánica', '8 tareas'),
                      _buildSubsystemCard('Programación', '6 tareas'),
                      _buildSubsystemCard('Estrategia', '5 tareas'),
                      _buildSubsystemCard('Drivers', '4 tareas'),
                      _buildSubsystemCard('Redes Sociales', '1 tareas'),
                      _buildSubsystemCard('Junta', '0 tareas'),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddHoursScreen()),
                );
              },
              child: Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSubsystemCard(String title, String count) {
    Color backgroundColor = Colors.grey[800]!;
    if (dummyData['subsistemas'] != null &&
        (dummyData['subsistemas'] as List).contains(title)) {
      backgroundColor = dummyData['liderSubsistema'] == title ? Colors.green : Colors.red;
    }

    Color countTextColor = (backgroundColor == Colors.red || backgroundColor == Colors.green)
        ? Colors.black
        : Colors.grey;

    FontWeight countFontWeight = (backgroundColor == Colors.red || backgroundColor == Colors.green)
        ? FontWeight.bold
        : FontWeight.normal;

    return SizedBox(
      height: 60,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                fontSize: 14,
                fontWeight: countFontWeight,
                color: countTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
