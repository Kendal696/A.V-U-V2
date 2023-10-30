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
            Container(
              margin: margin,
              width: double.infinity,
              height: 198,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    width: double.infinity,
                    height: 198,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 11,
                    top: 19,
                    child: SizedBox(
                      width: 287,
                      child: Text(
                        'Cuales son los eventos mas cercanos o conferencias?',
                        style: TextStyle(
                          color: Color(0xFFA0A0A0),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
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
            Container(
              margin: margin,
              width: 280,
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.50, color: Color(0xFF9E0044)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 267,
                    height: 32,
                    child: Text(
                      '¿Como averiguo información acerca de las becas?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9E0044),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: margin,
              width: 300,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.50, color: Color(0xFF9E0044)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      '¿Dónde se encuentra el edificio...?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9E0044),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: margin,
              width: 75,
              height: 75,
              child: Stack(
                children: [
                  Container(
                    margin: margin,
                    width: 75,
                    height: 75,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9E0044),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
