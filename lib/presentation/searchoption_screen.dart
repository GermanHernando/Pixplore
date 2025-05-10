import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import '../features/camera/camera_device.dart' as local_camera;
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final local_camera.CameraDevice _cameraDevice = local_camera.CameraDevice();
  bool _isInitialized = false;
  bool _showCamera = false;

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();

    if (!mounted) return;

    if (status.isGranted) {
      await _cameraDevice.initialize();
      if (!mounted) return;

      setState(() {
        _isInitialized = true;
        _showCamera = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    }
  }

  Future<void> _takePicture() async {
    final image = await _cameraDevice.controller?.takePicture();
    if (!mounted) return;

    if (image != null) {
      context.push('/preview', extra: image.path);
    }
  }

  void _simulateGallerySelection() {
    context.push('/gallery-grid');
  }

  @override
  void dispose() {
    _cameraDevice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showCamera && _isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CameraPreview(_cameraDevice.controller!),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FloatingActionButton(
                  onPressed: _takePicture,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.camera,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Pixplore',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _initCamera,
                  icon: const Icon(Icons.camera_alt, size: 36),
                  tooltip: 'Tomar foto',
                  color: const Color.fromARGB(255, 34, 176, 236),
                ),
                IconButton(
                  onPressed: _simulateGallerySelection,
                  icon: const Icon(Icons.photo_library, size: 36),
                  tooltip: 'Elegir de galería',
                  color: const Color.fromARGB(255, 34, 176, 236),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
