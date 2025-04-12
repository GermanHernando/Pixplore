import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import '../features/camera/camera_device.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CameraDevice _cameraDevice = CameraDevice();
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
                'RecoProdu',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: InkWell(
                onTap: _initCamera,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black87,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
