import 'dart:math';

import 'package:flutter/material.dart';
import '../models/usuario.dart';
import 'package:flutter/foundation.dart';
import '../screens/home_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Usuario> usuarios = [];
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  int? _editId;

  void _addOrUpdateUsuario() {
    if (_editId == null) {
      setState(() {
        usuarios.add(Usuario(
          id: Random().nextInt(1000),
          nombre: _nombreController.text,
          email: _emailController.text,
        ));
      });
    } else {
      setState(() {
        final index = usuarios.indexWhere((user) => user.id == _editId);
        if (index != -1) {
          usuarios[index].nombre = _nombreController.text;
          usuarios[index].email = _emailController.text;
        }
      });
      _editId = null;
    }
    _nombreController.clear();
    _emailController.clear();
  }

  void _deleteUsuario(int id) {
    setState(() {
      usuarios.removeWhere((user) => user.id == id);
    });
  }

  void _editUsuario(Usuario usuario) {
    _nombreController.text = usuario.nombre;
    _emailController.text = usuario.email;
    _editId = usuario.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Usuarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addOrUpdateUsuario,
              child: Text(
                  _editId == null ? 'Agregar Usuario' : 'Actualizar Usuario'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  return ListTile(
                    title: Text(usuario.nombre),
                    subtitle: Text(usuario.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editUsuario(usuario),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteUsuario(usuario.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
