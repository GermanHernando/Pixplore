import 'package:camera/camera.dart';

class CameraDevice {
  CameraController? controller;

  Future<void> initialize() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.first;

    controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller!.initialize();
  }

  void dispose() {
    controller?.dispose();
  }
}
