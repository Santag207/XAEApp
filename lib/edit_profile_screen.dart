import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _carrera = '';
  int _edad = 0;
  String _rango = '';
  String _cumpleanos = '';

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil actualizado (Simulación).')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _nombre = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Ingrese un nombre' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Carrera'),
                onSaved: (value) => _carrera = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Ingrese una carrera' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                _edad = int.tryParse(value ?? '0') ?? 0,
                validator: (value) =>
                value == null || value.isEmpty ? 'Ingrese una edad' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rango'),
                onSaved: (value) => _rango = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Ingrese un rango' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cumpleaños'),
                onSaved: (value) => _cumpleanos = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Ingrese una fecha' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
