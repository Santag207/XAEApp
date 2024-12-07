import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'qr_scanner_screen.dart';
import 'profile_screen.dart';
import 'reserved_items_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  // Lista de pantallas con la pantalla de inicio como primera opción
  final List<Widget> _screens = [
    HomeScreen(),         // Pantalla de inicio
    QRScannerScreen(),    // Pantalla de escaneo QR
    ProfileScreen(),      // Pantalla de perfil
    ReservedItemsScreen() // Pantalla de piezas
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.black, // Fondo negro del menú
        selectedItemColor: Colors.red, // Color rojo para el ítem seleccionado
        unselectedItemColor: Colors.black, // Color negro para ítems no seleccionados
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Escanear QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Piezas',
          ),
        ],
      ),
    );
  }
}
