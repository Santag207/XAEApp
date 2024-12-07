import 'package:flutter/material.dart';

class ItemListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummyScannedItems = [
    {'nombre': 'Pieza 1', 'cantidad': 10},
    {'nombre': 'Pieza 2', 'cantidad': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ítems Escaneados'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: dummyScannedItems.length,
        itemBuilder: (context, index) {
          final item = dummyScannedItems[index];
          return ListTile(
            title: Text(item['nombre']),
            subtitle: Text('Cantidad: ${item['cantidad']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Simulación: Lista confirmada')),
          );
        },
        child: Text('Apartar'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
