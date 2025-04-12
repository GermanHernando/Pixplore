import 'dart:io';
import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatelessWidget {
  final String imagePath;

  const CameraPreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foto tomada')),
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
