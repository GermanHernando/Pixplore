import 'package:go_router/go_router.dart';
import '../presentation/home_screen.dart';
import '../features/camera/camera_preview_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/preview',
      builder: (context, state) {
        final imagePath = state.extra as String;
        return CameraPreviewScreen(imagePath: imagePath);
      },
    ),
  ],
);
