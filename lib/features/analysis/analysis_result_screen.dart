import 'package:flutter/material.dart';

class AnalysisResultScreen extends StatelessWidget {
  final List<String> labels;

  const AnalysisResultScreen({super.key, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados de análisis')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children:
              labels
                  .map(
                    (label) => ListTile(
                      title: Text(label),
                      leading: const Icon(Icons.label),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
