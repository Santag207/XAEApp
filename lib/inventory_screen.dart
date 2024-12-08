import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Map<String, dynamic>> dummyScannedItems = [
    {'nombre': 'Pieza 1', 'cantidad': 10},
    {'nombre': 'Pieza 2', 'cantidad': 5},
    {'nombre': 'Pieza 3', 'cantidad': 7},
  ];

  final List<Map<String, dynamic>> dummyRegisteredItems = [
    {'nombre': 'Pieza 1', 'codigo': 'PZ001', 'apartadoPor': 'Juan Pérez', 'fecha': DateTime(2024, 12, 10), 'cantidad': 2},
    {'nombre': 'Pieza 2', 'codigo': 'PZ002', 'apartadoPor': 'María López', 'fecha': DateTime(2024, 12, 12), 'cantidad': 1},
    {'nombre': 'Pieza 3', 'codigo': 'PZ003', 'apartadoPor': 'Juan Pérez', 'fecha': DateTime(2024, 12, 13), 'cantidad': 3},
  ];

  String searchQueryLista = ''; // Nueva variable para el buscador de "Lista"
  String searchQuery = ''; // Variable existente para "Registrados"
  String? selectedIntegrante;
  bool isViewingRegistered = false;

  @override
  Widget build(BuildContext context) {
    // Filtrar piezas por nombre en lista
    final filteredScannedItems = dummyScannedItems
        .where((item) => item['nombre'].toLowerCase().contains(searchQueryLista.toLowerCase()))
        .toList();

    // Filtrar piezas por nombre en registradas
    final filteredRegisteredItems = dummyRegisteredItems
        .where((item) =>
    (selectedIntegrante == null || item['apartadoPor'] == selectedIntegrante) &&
        item['nombre'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 35.0), // Ajusta el padding superior
          child: Text(
            'Gestión de Piezas',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding global para ambos buscadores
        child: Column(
          children: [
            // Botones de Lista y Registrados
            Padding(
              padding: EdgeInsets.only(top: 45.0), // Padding superior restaurado
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildToggleButton('Lista de Piezas', false),
                  _buildToggleButton('Piezas Registradas', true),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Mostrar el buscador exclusivo para "Lista"
            if (!isViewingRegistered)
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre de pieza...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQueryLista = value; // Actualizar búsqueda de "Lista"
                  });
                },
              ),

            // Mostrar buscador y dropdown exclusivo para "Registrados"
            if (isViewingRegistered)
              Row(
                children: [
                  // Buscador de texto para "Registrados"
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Buscar por nombre de pieza...',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        prefixIcon: Icon(Icons.search, color: Colors.white), // Icono de lupa agregado
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),

                  // Dropdown para seleccionar integrante
                  DropdownButton<String>(
                    value: selectedIntegrante,
                    hint: Text('Integrante', style: TextStyle(color: Colors.grey)),
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white),
                    items: [
                      ...dummyRegisteredItems
                          .map((item) => item['apartadoPor'])
                          .toSet()
                          .map((integrante) {
                        return DropdownMenuItem<String>(
                          value: integrante,
                          child: Text(integrante),
                        );
                      }).toList()
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedIntegrante = value;
                      });
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),

            // Lista de ítems
            Expanded(
              child: isViewingRegistered
                  ? ListView.builder(
                itemCount: filteredRegisteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredRegisteredItems[index];
                  return ListTile(
                    title: Text(
                      '${item['nombre']} (${item['codigo']})',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${item['apartadoPor']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () => _showRegisteredItemDetails(context, item),
                  );
                },
              )
                  : ListView.builder(
                itemCount: filteredScannedItems.length,
                itemBuilder: (context, index) {
                  final item = filteredScannedItems[index];
                  return ListTile(
                    title: Text(item['nombre'], style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      'Cantidad disponible: ${item['cantidad']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () => _showAvailableItemDetails(context, item),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Botón flotante para escanear QR
      floatingActionButton: FloatingActionButton(
        onPressed: _openQrScanner, // Llama a la función creada
        backgroundColor: Colors.white,
        child: Icon(Icons.qr_code, color: Colors.black),
      ),
    );
  }

  // Botón de alternancia (Lista o Registrados)
  Widget _buildToggleButton(String text, bool viewRegistered) {
    final isSelected = isViewingRegistered == viewRegistered;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.red, // Cambiar el color del botón activo
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: () {
        setState(() {
          isViewingRegistered = viewRegistered;
          searchQuery = '';
          selectedIntegrante = null;
        });
      },
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.black : Colors.white), // Cambiar el color del texto
      ),
    );
  }

  // Mostrar detalles de un ítem disponible
  void _showAvailableItemDetails(BuildContext context, Map<String, dynamic> item) {
    final int piezasOcupadas = dummyRegisteredItems
        .where((e) => e['nombre'] == item['nombre']) // Buscar coincidencias por nombre
        .fold<int>(0, (sum, e) => sum + (e['cantidad'] as int)); // Sumar cantidades ocupadas

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
              Text(
                'Detalles del Ítem Disponible',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text('Nombre: ${item['nombre']}', style: TextStyle(color: Colors.white)),
              Text('Cantidad disponible: ${item['cantidad']}', style: TextStyle(color: Colors.white)),
              Text('Piezas ocupadas: $piezasOcupadas', style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      },
    );
  }

  // Mostrar detalles de un ítem registrado
  void _showRegisteredItemDetails(BuildContext context, Map<String, dynamic> item) {
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
              Text('Detalles del Ítem Registrado', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Nombre: ${item['nombre']}', style: TextStyle(color: Colors.white)),
              Text('Código: ${item['codigo']}', style: TextStyle(color: Colors.white)),
              Text('Apartado por: ${item['apartadoPor']}', style: TextStyle(color: Colors.white)),
              Text('Fecha de apartado: ${item['fecha']}', style: TextStyle(color: Colors.white)),
              Text('Cantidad apartada: ${item['cantidad']}', style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      },
    );
  }

  void _openQrScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerScreen(), // Importa la pantalla QRScannerScreen
      ),
    );
  }
}
