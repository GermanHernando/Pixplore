import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixplore/services/rekognition_service.dart';

class CameraPreviewScreen extends StatelessWidget {
  final String imagePath;

  const CameraPreviewScreen({super.key, required this.imagePath});

  Future<void> _analyzeImage(BuildContext context) async {
    final bytes = await File(imagePath).readAsBytes();
    final rekognition = RekognitionService();
    final labels = await rekognition.detectLabels(bytes);
    if (context.mounted) {
      context.push('/analysis', extra: labels);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foto tomada')),
      body: Column(
        children: [
          Expanded(child: Image.file(File(imagePath))),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ElevatedButton(
              onPressed: () => _analyzeImage(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 34, 176, 236),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Analizar Imagen',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
