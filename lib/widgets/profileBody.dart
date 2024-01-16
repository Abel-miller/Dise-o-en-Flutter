import 'dart:io';

import 'package:flutter/material.dart';
import 'package:perfilusuario/screens/editProfileScreen.dart';

class UserProfileBody extends StatelessWidget {
  final String name;
  final String email;
  final File? image;
  final Function(String, String, File?) updateProfile;
  final VoidCallback selectImage;

  UserProfileBody({
    required this.name,
    required this.email,
    required this.image,
    required this.updateProfile,
    required this.selectImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: selectImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageProvider(),
                backgroundColor: Colors.grey[300],
                child: image == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ) // Icono de persona como marcador de posición
                    : null,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Correo electrónico: $email',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: Theme.of(context).brightness == Brightness.dark
        ? Colors.blue // Color en modo oscuro
        : const Color.fromARGB(255, 62, 62, 62), // Color en modo claro (ajusta según tus preferencias)
    onPrimary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  onPressed: () async {
    Map<String, dynamic>? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialName: name,
          initialEmail: email,
          initialImage: image,
        ),
      ),
    );

    if (result != null &&
        result.containsKey('name') &&
        result.containsKey('email')) {
      // Update the profile in UserProfileScreen
      updateProfile(result['name'], result['email'], result['image']);
    }
  },
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.edit, size: 20),
        SizedBox(width: 10),
        Text('Editar Perfil', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object>? _imageProvider() {
    if (image != null) {
      return FileImage(image!);
    } else {
      return AssetImage('lib/assets/perfil.png');
    }
  }
}
