import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  // Inicializar los servicios de Flutter y los plugins
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Javex Robotics',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen(),
    );
  }
}
