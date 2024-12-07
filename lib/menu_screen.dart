import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'qr_scanner_screen.dart';
import 'profile_screen.dart';
import 'item_list_screen.dart';
import 'pending_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  // Lista de pantallas con la pantalla de inicio como primera opción
  final List<Widget> _screens = [
    HomeScreen(),         // Pantalla de inicio
    PendingScreen(),      // Pantalla de pendientes
    QRScannerScreen(),    // Pantalla de escaneo QR
    ItemListScreen(),    // Pantalla de piezas
    ProfileScreen(),      // Pantalla de perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.black,
            onTap: (index) {
              if (index != 2) {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            items: [
              _buildAnimatedItem(Icons.home, 'Inicio', 0),
              _buildAnimatedItem(Icons.list_alt, 'Pendientes', 1),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Espacio vacío para el botón QR
                label: '',
              ),
              _buildAnimatedItem(Icons.widgets_outlined, 'Piezas', 3),
              _buildAnimatedItem(Icons.person, 'Perfil', 4),
            ],
          ),
          Positioned(
            bottom: 5, // Ajustar la posición del botón QR
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2; // El botón central navega a Escanear QR
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: Icon(
                  Icons.qr_code, // Ícono QR
                  size: 28, // Tamaño del ícono
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Método para crear los ítems animados
  BottomNavigationBarItem _buildAnimatedItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: _currentIndex == index ? 1.2 : 1.0),
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Icon(
              icon,
              color: _currentIndex == index ? Colors.white : Colors.grey,
            ),
          );
        },
      ),
      label: label,
    );
  }
}
