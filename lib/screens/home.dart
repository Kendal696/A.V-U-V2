// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    const EdgeInsets margin = EdgeInsets.all(10.0);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: margin,
              width: double.infinity,
              height: 12,
              color: const Color(0xFFEDF0EF),
            ),
            SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 35,
              width: 300,
              child: Text(
                'Asistente de Voz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.05,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Ajusta el espacio horizontal
              child: TextField(
                minLines: 5,
                maxLines: 7,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  hintText: 'Escribe tu pregunta aquí...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black, // Color del borde
                      width: 2.0, // Grosor del borde
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.black87,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button's functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9E0044),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Preguntar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFCFCFC),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              height: 3,
              width: 300,
              child: const Text(
                'Preguntas Frecuentes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9E0044),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0.05,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your button's functionality here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xFF9E0044),
                side: BorderSide(width: 1.50, color: Color(0xFF9E0044)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: SizedBox(
                width: 267,
                height: 32,
                child: Text(
                  '¿Como averiguo información acerca de las becas?',
                  textAlign: TextAlign.center, // Centra el texto
                  style: TextStyle(
                    color: Color(0xFF9E0044),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your button's functionality here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xFF9E0044),
                side: BorderSide(width: 1.50, color: Color(0xFF9E0044)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: SizedBox(
                width: 250,
                child: Text(
                  '¿Dónde se encuentra el edificio...?',
                  textAlign: TextAlign.center, // Centra el texto
                  style: TextStyle(
                    color: Color(0xFF9E0044),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF9E0044),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  // TODO: Implement microphone button functionality
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
