import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeWelcome extends StatelessWidget {
  const HomeWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 34, 176, 236),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              'Esto es Pixplore',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 34, 176, 236),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Una experiencia única que te muestra cualquier producto en detalle, compara precios y te indica en qué e-commerce podés comprarlo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/camera');
              },

              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 34, 176, 236),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Comenzar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomeWelcome(), debugShowCheckedModeBanner: false));
}
