import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final File? image;
  
  const ProfileImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: image != null ? FileImage(image!) : null,
        child: image == null ? const Icon(Icons.person, size: 50) : null,
      ),
    );
  }
}