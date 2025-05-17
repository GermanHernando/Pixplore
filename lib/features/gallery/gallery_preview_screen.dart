import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pixplore/services/rekognition_service.dart';

class GalleryPreviewScreen extends StatelessWidget {
  final String imageAssetPath;

  const GalleryPreviewScreen({super.key, required this.imageAssetPath});

  Future<void> _analyzeAsset(BuildContext context) async {
    final byteData = await rootBundle.load(imageAssetPath);
    final bytes = byteData.buffer.asUint8List();
    final rekognition = RekognitionService();
    final labels = await rekognition.detectLabels(bytes);
    if (context.mounted) {
      context.push('/analysis', extra: labels);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulación galería')),
      body: Column(
        children: [
          Expanded(child: Image.asset(imageAssetPath)),
          const SizedBox(height: 20), // separa imagen del botón
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ElevatedButton(
              onPressed: () => _analyzeAsset(context),
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
