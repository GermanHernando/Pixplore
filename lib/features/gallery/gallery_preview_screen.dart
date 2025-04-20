import 'package:flutter/material.dart';

class GalleryPreviewScreen extends StatelessWidget {
  final String imageAssetPath;

  const GalleryPreviewScreen({super.key, required this.imageAssetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulación galería')),
      body: Center(child: Image.asset(imageAssetPath)),
    );
  }
}
