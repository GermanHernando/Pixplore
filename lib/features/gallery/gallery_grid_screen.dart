import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryGridScreen extends StatelessWidget {
  const GalleryGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/images/gallery1.jpg',
      'assets/images/gallery2.jpg',
      'assets/images/gallery3.jpg',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Simular galería')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push('/gallery-preview', extra: images[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(images[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
