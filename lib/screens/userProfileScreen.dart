import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:perfilusuario/widgets/profileBody.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _name = 'Nombre de Usuario';
  String _email = 'usuario@example.com';
  File? _image;

  void _updateProfile(String newName, String newEmail, File? newImage) {
    setState(() {
      _name = newName;
      _email = newEmail;
      _image = newImage;
    });
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
        title: Text('Perfil de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UserProfileBody(
          name: _name,
          email: _email,
          image: _image,
          updateProfile: _updateProfile,
          selectImage: _selectImage,
        ),
      ),
    );
  }
}
