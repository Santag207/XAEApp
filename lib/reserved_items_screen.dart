import 'package:flutter/material.dart';

class ReservedItemsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummyItems = [
    {'nombre': 'Pieza 1', 'cantidad': 5, 'estado': 'Apartada'},
    {'nombre': 'Pieza 2', 'cantidad': 3, 'estado': 'Apartada'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piezas Apartadas'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: dummyItems.length,
        itemBuilder: (context, index) {
          final item = dummyItems[index];
          return ListTile(
            title: Text(item['nombre']),
            subtitle: Text('Cantidad: ${item['cantidad']}'),
            trailing: Text(item['estado']),
          );
        },
      ),
    );
  }
}
