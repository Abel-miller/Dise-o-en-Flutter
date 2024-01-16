import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final File? initialImage;

  EditProfileScreen({
    required this.initialName,
    required this.initialEmail,
    required this.initialImage,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  File? _image;

  @override
  void initState() {
    _nameController.text = widget.initialName;
    _emailController.text = widget.initialEmail;
    _image = widget.initialImage;
    super.initState();
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectImage,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: const Color.fromARGB(255, 62, 62, 62),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    backgroundColor: Colors.transparent,
                  ),
                  if (_image == null)
                    Icon(Icons.camera_alt, size: 40, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre', style: TextStyle(color: Colors.grey)),
                TextFormField(
                  controller: _nameController,
                  onTap: () {
                    if (_nameController.text == 'Nombre de Usuario') {
                      _nameController.clear();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Correo electrónico', style: TextStyle(color: Colors.grey)),
                TextFormField(
                  controller: _emailController,
                  onTap: () {
                    if (_emailController.text == 'usuario@example.com') {
                      _emailController.clear();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'usuario@example.com',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveChanges();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 62, 62, 62),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text('Guardar Cambios', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    String newName = _nameController.text;
    String newEmail = _emailController.text;

    print('Nombre actualizado: $newName');
    print('Correo electrónico actualizado: $newEmail');
    print('Imagen actualizada: $_image');

    Navigator.pop(context, {'name': newName, 'email': newEmail, 'image': _image});
  }
}
